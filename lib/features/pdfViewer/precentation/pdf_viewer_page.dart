import 'dart:io';

// 1. استدعاءات المكتبات والكيوبت الجديد
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/utils/functions/pdf_viewer_helper.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/cubit/pdf_search_state_cubit.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_cubit.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_state.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdfViewerAppbar.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_page_indicator.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_search_result_widget.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_view_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

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
    this.currentPage,
    this.book,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentPage != null && widget.currentPage! > 0) {
        _pdfViewerController.jumpToPage(widget.currentPage! + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfViewerCubit()), // ✅ كيوبت الصفحة
        BlocProvider(create: (context) => PdfSearchCubit()), // كيوبت البحث
      ],

      // 2. استخدام BlocBuilder للاستماع لتغيرات الحالة
      child: BlocBuilder<PdfViewerCubit, PdfViewerState>(
        builder: (context, state) {
          // تحديد فلتر الألوان بناءً على state.isNightMode
          final colorFilter =
              state.isNightMode
                  ? AppConstants
                      .colorFilter // تأكد أن لديك هذا الثابت
                  : const ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.saturation,
                  );

          return Scaffold(
            appBar: PdfViewerAppBar(
              title: widget.book?.title ?? "قارئ الكتب",

              // ✅ البيانات تأتي من state
              isNightMode: state.isNightMode,

              onSearchTap:
                  () =>
                      PdfViewDialogs.showSearch(context, _pdfViewerController),

              // ✅ تغيير الحالة عبر الكيوبت
              onNightModeTap:
                  () => context.read<PdfViewerCubit>().toggleNightMode(),

              // ✅ الحفظ يستخدم البيانات من state والكونترولر
              onSaveTap:
                  () => PdfViewerHelper.saveProgress(
                    context,
                    userId: widget.userId,
                    bookId: widget.bookId,
                    book: widget.book,
                    controller: _pdfViewerController,
                    totalPages: state.totalPages, // نأخذ القيمة من الـ State
                    isDisposing: false,
                  ),
            ),

            body: Stack(
              children: [
                ColorFiltered(
                  colorFilter: colorFilter,
                  child: SfPdfViewer.file(
                    File(widget.filePath),
                    controller: _pdfViewerController,
                    key: _pdfViewerKey,
                    enableTextSelection: true,

                    // ✅ عند التحميل: نحدث الكيوبت
                    onDocumentLoaded: (details) {
                      context.read<PdfViewerCubit>().setTotalPages(
                        _pdfViewerController.pageCount,
                      );
                    },

                    // ✅ عند تغيير الصفحة: نحدث الكيوبت
                    onPageChanged: (details) {
                      context.read<PdfViewerCubit>().updatePage(
                        details.newPageNumber,
                      );
                    },
                  ),
                ),

                const PdfSearchResultWidget(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ⚠️ ملاحظة هامة بخصوص dispose:
  // لا يمكننا الوصول لـ context.read داخل dispose بسهولة لأنه قد يكون widget unmounted
  // الحل الأفضل هو الاعتماد على Controller للحصول على الصفحة الحالية
  @override
  void dispose() {
    // لحسن الحظ، PdfViewerController يحتفظ برقم الصفحة الحالية بداخله
    // لكننا نحتاج totalPages. بما أننا لا نستطيع قراءة الكيوبت هنا بسهولة،
    // يمكننا استخدام _pdfViewerController.pageCount

    // ملاحظة: قد تحتاج للتأكد من أن الكيوبت لم يغلق بعد، أو الاعتماد على controller
    try {
      PdfViewerHelper.saveProgress(
        context,
        userId: widget.userId,
        bookId: widget.bookId,
        book: widget.book,
        controller: _pdfViewerController,
        // هنا نأخذ العدد من الكونترولر مباشرة لأنه أضمن في لحظة الإغلاق
        totalPages: _pdfViewerController.pageCount,
        isDisposing: true,
      );
    } catch (e) {
      // Ignored
    }

    super.dispose();
  }
}
