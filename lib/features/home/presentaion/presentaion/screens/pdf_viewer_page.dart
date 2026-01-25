import 'dart:io';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String filePath;
  final int bookId;
  final int userId;
  final int? currentPage;
  final BookEntity? book;

  const PdfViewerPage({
    super.key,
    required this.filePath,
    required this.bookId,
    required this.userId,
    this.currentPage = 0,
    this.book,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  // 1. Syncfusion Controller
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  
  // للبحث داخل الملف
  late PdfTextSearchResult _searchResult;

  int totalPages = 0;
  int currentPage = 1; // Syncfusion starts at 1 visually usually, but logic needs checking
  bool isNightMode = false;
  OverlayEntry? _overlayEntry; // للبحث

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    
    // القفز للصفحة المحفوظة عند البدء
    // ملاحظة: قد تحتاج لتأخير بسيط لضمان تحميل الملف
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentPage != null && widget.currentPage! > 0) {
        _pdfViewerController.jumpToPage(widget.currentPage! + 1);
      }
    });
  }

  @override
  void dispose() {
    _saveProgress(isDisposing: true);
    super.dispose();
  }

  // حفظ التقدم
  void _saveProgress({bool isDisposing = false}) {
    // في Syncfusion رقم الصفحة الحالي متاح مباشرة
    final int current = _pdfViewerController.pageNumber;
    final int total = _pdfViewerController.pageCount;

    if (total == 0) return;

    // Syncfusion pages are 1-based index usually, ReadingProgress often expects 0-based or 1-based depending on your logic.
    // Assuming backend takes 0-based index:
    final int pageIndexToSave = current - 1; 

    final progress = ReadingProgressEntity(
      userId: widget.userId,
      bookId: widget.bookId,
      currentPage: pageIndexToSave,
      totalPages: total,
      isCompleted: current == total,
      book: widget.book,
    );

    try {
      getIt<ReadingProgressCubit>().saveProgress(progress);
      if (!isDisposing && mounted) {
        CustomSnackBar.show(
          context: context,
          message: "تم حفظ التقدم بنجاح",
        );
      }
    } catch (e) {
      if (!isDisposing && mounted) {
        CustomSnackBar.show(
          context: context,
          message: "فشل حفظ التقدم",
          isError: true,
        );
      }
    }
  }

  // نافذة الذهاب لصفحة
  void _showGoToPageDialog() {
    final TextEditingController pageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("الذهاب إلى صفحة"),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "أدخل رقم الصفحة (1 - ${_pdfViewerController.pageCount})",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                final int? page = int.tryParse(pageController.text);
                if (page != null && page > 0 && page <= _pdfViewerController.pageCount) {
                  _pdfViewerController.jumpToPage(page);
                  Navigator.pop(context);
                }
              },
              child: const Text("ذهاب"),
            ),
          ],
        );
      },
    );
  }

  // نافذة البحث
  void _showSearchDialog() {
    final TextEditingController searchController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("بحث في الملف"),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(hintText: "اكتب كلمة للبحث..."),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _searchResult.clear();
                  Navigator.pop(context);
                },
                child: const Text("إلغاء")),
            ElevatedButton(
              onPressed: () {
                _searchResult = _pdfViewerController.searchText(searchController.text);
                setState(() {}); // لتحديث الواجهة وعرض أزرار التنقل في البحث
                Navigator.pop(context);
                
                // إظهار رسالة بعدد النتائج
                if (_searchResult.totalInstanceCount == 0) {
                   CustomSnackBar.show(context: context, message: "لم يتم العثور على نتائج", isError: true);
                } else {
                   CustomSnackBar.show(context: context, message: "تم العثور على ${_searchResult.totalInstanceCount} نتيجة");
                }
              },
              child: const Text("بحث"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // مصفوفة الألوان لعكس الألوان في الوضع الليلي
    // هذه الحيلة تتيح الوضع الليلي في أي مكتبة
    final colorFilter = isNightMode
        ? const ColorFilter.matrix([
            -1,  0,  0, 0, 255,
             0, -1,  0, 0, 255,
             0,  0, -1, 0, 255,
             0,  0,  0, 1,   0,
          ])
        : const ColorFilter.mode(Colors.transparent, BlendMode.saturation);

    return Scaffold(
      appBar: AppBar(
        title: const Text("قارئ الكتب"),
        backgroundColor: AppColors.primary,
        actions: [
          // زر البحث
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          // زر الوضع الليلي
          IconButton(
            icon: Icon(isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isNightMode = !isNightMode;
              });
            },
          ),
          // زر الحفظ اليدوي
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveProgress(isDisposing: false),
          ),
        ],
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: colorFilter,
            child: SfPdfViewer.file(
              File(widget.filePath),
              controller: _pdfViewerController,
              key: _pdfViewerKey,
              enableTextSelection: true, // ✅ ميزة تحديد النص ونسخه
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                setState(() {
                  totalPages = _pdfViewerController.pageCount;
                });
              },
              onPageChanged: (PdfPageChangedDetails details) {
                setState(() {
                  // details.newPageNumber starts at 1
                  currentPage = details.newPageNumber;
                });
              },
            ),
          ),

          // شريط أدوات البحث (يظهر فقط عند وجود نتائج بحث)
          if (_searchResult.hasResult)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      '${_searchResult.currentInstanceIndex} / ${_searchResult.totalInstanceCount}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      onPressed: () {
                        _searchResult.previousInstance();
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        _searchResult.nextInstance();
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _searchResult.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

          // مؤشر الصفحة العائم (Floating Page Indicator)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _showGoToPageDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.menu_book, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        "$currentPage / $totalPages",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}