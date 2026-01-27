import 'package:clean_architecture/features/pdfViewer/precentation/manager/cubit/pdf_search_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewDialogs {
  
  // نافذة الذهاب لصفحة معينة
  static void showGoToPage(
      BuildContext context, PdfViewerController controller, int totalPages) {
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
              hintText: "أدخل رقم (1 - $totalPages)",
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
                if (page != null && page > 0 && page <= totalPages) {
                  controller.jumpToPage(page);
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
  static void showSearch(
    BuildContext context,
    PdfViewerController controller,
  ) {
    final TextEditingController searchController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("بحث في الملف"),
          content: TextField(
            controller: searchController,
            decoration: const InputDecoration(hintText: "اكتب كلمة..."),
            autofocus: true,
            onSubmitted: (value) {
               // دعم الضغط على Enter
               context.read<PdfSearchCubit>().startSearch(value, controller);
               Navigator.pop(dialogContext);
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("إلغاء")),
            ElevatedButton(
              onPressed: () {
                // ✅ هنا نستدعي الكيوبت لبدء البحث
                context.read<PdfSearchCubit>().startSearch(searchController.text, controller);
                Navigator.pop(dialogContext);
              },
              child: const Text("بحث"),
            ),
          ],
        );
      },
    );
  }

}