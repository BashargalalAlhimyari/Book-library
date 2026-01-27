import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/widgets/shared/custom_snack_bar.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart';

class PdfViewerHelper {
  // جعلنا الدالة static ليسهل استدعاؤها
  static void saveProgress(
    BuildContext context, {
    required int userId,
    required int bookId,
    required BookEntity? book,
    required PdfViewerController controller,
    required int totalPages,
    bool isDisposing = false,
  }) {
    // 1. التحقق من أن الملف محمل
    if (totalPages == 0) return;

    // 2. تجهيز البيانات
    final int current = controller.pageNumber;
    final int pageIndexToSave = current - 1;

    final progress = ReadingProgressEntity(
      userId: userId,
      bookId: bookId,
      currentPage: pageIndexToSave,
      totalPages: totalPages,
      isCompleted: current == totalPages,
      book: book,
    );

    // 3. التنفيذ
    try {
      getIt<ReadingProgressCubit>().saveProgress(progress);

      // التحقق من context.mounted ضروري عند استخدام دوال static
      if (!isDisposing && context.mounted) {
        CustomSnackBar.show(
          context: context,
          message: "تم حفظ التقدم بنجاح ✅",
        );
      }
    } catch (e) {
      if (!isDisposing && context.mounted) {
        CustomSnackBar.show(
          context: context,
          message: "فشل حفظ التقدم ❌",
          isError: true,
        );
      }
    }
  }
}