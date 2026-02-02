import 'dart:io';
import 'package:camera/camera.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/services/head_gesture_service.dart'; // تأكد من المسار
import 'package:clean_architecture/core/utils/functions/pdf_viewer_helper.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/cubit/pdf_search_state_cubit.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_cubit.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_state.dart';
import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdfViewerAppbar.dart';
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

// ✅ 1. أضفنا WidgetsBindingObserver لمراقبة حالة التطبيق
class _PdfViewerPageState extends State<PdfViewerPage> with WidgetsBindingObserver {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  CameraController? _cameraController;
  final HeadGestureService _headService = HeadGestureService();
  bool _isCameraInitialized = false;
  DateTime? _lastFrameTime; // متغير التوقيت

  @override
  void initState() {
    super.initState();
    // ✅ تسجيل المراقب
    WidgetsBinding.instance.addObserver(this);

    _pdfViewerController = PdfViewerController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentPage != null && widget.currentPage! > 0) {
        _pdfViewerController.jumpToPage(widget.currentPage! + 1);
      }
    });

    _initializeSmartScroll();
  }

  // ✅ 2. دالة التعامل مع الخروج والدخول للتطبيق (مهمة جداً لمنع الانهيار)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // إيقاف الكاميرا عند الخروج
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // إعادة تشغيلها عند العودة
      _initializeSmartScroll();
    }
  }

  Future<void> _initializeSmartScroll() async {
    // تنظيف الكنترولر القديم إذا وجد
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium, 
        enableAudio: false,
        // ✅ 3. إصلاح الصيغة لتكون متوافقة مع الأندرويد والآيفون
        imageFormatGroup: Platform.isAndroid 
            ? ImageFormatGroup.yuv420 
            : ImageFormatGroup.bgra8888,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      _cameraController!.startImageStream((image) {
        // شرط الوقت (ثانية واحدة)
        if (_lastFrameTime != null && 
            DateTime.now().difference(_lastFrameTime!).inMilliseconds < 1000) {
          image.planes.map((p) => p.bytes).toList(); // تفريغ الذاكرة
          return; 
        }
        
        _lastFrameTime = DateTime.now();

        // إرسال الصورة للمعالجة
        _headService.processImage(
          image,
          frontCamera,
          _goToNextPage,
          _goToPrevPage,
        );
      });

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Error initializing smart scroll: $e");
    }
  }

  void _goToNextPage() {
    // فحص إذا كان الكنترولر جاهزاً
    _pdfViewerController.nextPage();
  }

  void _goToPrevPage() {
    _pdfViewerController.previousPage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfViewerCubit()),
        BlocProvider(create: (context) => PdfSearchCubit()),
      ],
      child: BlocBuilder<PdfViewerCubit, PdfViewerState>(
        builder: (context, state) {
          final colorFilter = state.isNightMode
              ? AppConstants.colorFilter
              : const ColorFilter.mode(Colors.transparent, BlendMode.saturation);

          return Scaffold(
            appBar: PdfViewerAppBar(
              title: widget.book?.title ?? "قارئ الكتب",
              isNightMode: state.isNightMode,
              onSearchTap: () => PdfViewDialogs.showSearch(context, _pdfViewerController),
              onNightModeTap: () => context.read<PdfViewerCubit>().toggleNightMode(),
              onSaveTap: () => PdfViewerHelper.saveProgress(
                context,
                userId: widget.userId,
                bookId: widget.bookId,
                book: widget.book,
                controller: _pdfViewerController,
                totalPages: state.totalPages,
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
                    onDocumentLoaded: (details) {
                      context.read<PdfViewerCubit>().setTotalPages(_pdfViewerController.pageCount);
                    },
                    onPageChanged: (details) {
                      context.read<PdfViewerCubit>().updatePage(details.newPageNumber);
                    },
                  ),
                ),

                // الكاميرا المخفية
                if (_isCameraInitialized && _cameraController != null)
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Opacity(
                      opacity: 0.0,
                      child: SizedBox(
                        width: 1,
                        height: 1,
                        child: CameraPreview(_cameraController!),
                      ),
                    ),
                  ),

                // أيقونة الحالة (اختياري)
                if (_isCameraInitialized)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.face, color: Colors.white, size: 20),
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

  @override
  void dispose() {
    // ✅ 4. إلغاء المراقب
    WidgetsBinding.instance.removeObserver(this);
    
    // إيقاف تدفق الصور قبل التخلص من الكنترولر
    if (_cameraController != null && _cameraController!.value.isStreamingImages) {
       _cameraController!.stopImageStream();
    }
    _cameraController?.dispose();
    _headService.dispose();

    try {
      PdfViewerHelper.saveProgress(
        context,
        userId: widget.userId,
        bookId: widget.bookId,
        book: widget.book,
        controller: _pdfViewerController,
        totalPages: _pdfViewerController.pageCount,
        isDisposing: true,
      );
    } catch (e) {
      // Ignored
    }

    super.dispose();
  }
}










// import 'dart:io';

// // 1. استدعاءات المكتبات والكيوبت الجديد
// import 'package:clean_architecture/core/constants/app_constants.dart';
// import 'package:clean_architecture/core/utils/functions/pdf_viewer_helper.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/manager/cubit/pdf_search_state_cubit.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_cubit.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/manager/pdfViewrCubit/pdf_viewer_state.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdfViewerAppbar.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_page_indicator.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_search_result_widget.dart';
// import 'package:clean_architecture/features/pdfViewer/precentation/widgets/pdf_view_dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

// class PdfViewerPage extends StatefulWidget {
//   final String filePath;
//   final int bookId;
//   final int userId;
//   final int? currentPage;
//   final BookEntity? book;

//   const PdfViewerPage({
//     super.key,
//     required this.filePath,
//     required this.bookId,
//     required this.userId,
//     this.currentPage,
//     this.book,
//   });

//   @override
//   State<PdfViewerPage> createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<PdfViewerPage> {
//   late PdfViewerController _pdfViewerController;
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();


//   @override
//   void initState() {
//     super.initState();
//     _pdfViewerController = PdfViewerController();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.currentPage != null && widget.currentPage! > 0) {
//         _pdfViewerController.jumpToPage(widget.currentPage! + 1);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => PdfViewerCubit()), // ✅ كيوبت الصفحة
//         BlocProvider(create: (context) => PdfSearchCubit()), // كيوبت البحث
//       ],

//       // 2. استخدام BlocBuilder للاستماع لتغيرات الحالة
//       child: BlocBuilder<PdfViewerCubit, PdfViewerState>(
//         builder: (context, state) {
//           // تحديد فلتر الألوان بناءً على state.isNightMode
//           final colorFilter =
//               state.isNightMode
//                   ? AppConstants
//                       .colorFilter // تأكد أن لديك هذا الثابت
//                   : const ColorFilter.mode(
//                     Colors.transparent,
//                     BlendMode.saturation,
//                   );

//           return Scaffold(
//             appBar: PdfViewerAppBar(
//               title: widget.book?.title ?? "قارئ الكتب",

//               // ✅ البيانات تأتي من state
//               isNightMode: state.isNightMode,

//               onSearchTap:
//                   () =>
//                       PdfViewDialogs.showSearch(context, _pdfViewerController),

//               // ✅ تغيير الحالة عبر الكيوبت
//               onNightModeTap:
//                   () => context.read<PdfViewerCubit>().toggleNightMode(),

//               // ✅ الحفظ يستخدم البيانات من state والكونترولر
//               onSaveTap:
//                   () => PdfViewerHelper.saveProgress(
//                     context,
//                     userId: widget.userId,
//                     bookId: widget.bookId,
//                     book: widget.book,
//                     controller: _pdfViewerController,
//                     totalPages: state.totalPages, // نأخذ القيمة من الـ State
//                     isDisposing: false,
//                   ),
//             ),

//             body: Stack(
//               children: [
//                 ColorFiltered(
//                   colorFilter: colorFilter,
//                   child: SfPdfViewer.file(
//                     File(widget.filePath),
//                     controller: _pdfViewerController,
//                     key: _pdfViewerKey,
//                     enableTextSelection: true,

//                     // ✅ عند التحميل: نحدث الكيوبت
//                     onDocumentLoaded: (details) {
//                       context.read<PdfViewerCubit>().setTotalPages(
//                         _pdfViewerController.pageCount,
//                       );
//                     },

//                     // ✅ عند تغيير الصفحة: نحدث الكيوبت
//                     onPageChanged: (details) {
//                       context.read<PdfViewerCubit>().updatePage(
//                         details.newPageNumber,
//                       );
//                     },
//                   ),
//                 ),

//                 const PdfSearchResultWidget(),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ⚠️ ملاحظة هامة بخصوص dispose:
//   // لا يمكننا الوصول لـ context.read داخل dispose بسهولة لأنه قد يكون widget unmounted
//   // الحل الأفضل هو الاعتماد على Controller للحصول على الصفحة الحالية
//   @override
//   void dispose() {
//     // لحسن الحظ، PdfViewerController يحتفظ برقم الصفحة الحالية بداخله
//     // لكننا نحتاج totalPages. بما أننا لا نستطيع قراءة الكيوبت هنا بسهولة،
//     // يمكننا استخدام _pdfViewerController.pageCount

//     // ملاحظة: قد تحتاج للتأكد من أن الكيوبت لم يغلق بعد، أو الاعتماد على controller
//     try {
//       PdfViewerHelper.saveProgress(
//         context,
//         userId: widget.userId,
//         bookId: widget.bookId,
//         book: widget.book,
//         controller: _pdfViewerController,
//         // هنا نأخذ العدد من الكونترولر مباشرة لأنه أضمن في لحظة الإغلاق
//         totalPages: _pdfViewerController.pageCount,
//         isDisposing: true,
//       );
//     } catch (e) {
//       // Ignored
//     }

//     super.dispose();
//   }
// }
