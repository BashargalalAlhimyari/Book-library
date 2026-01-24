import 'package:clean_architecture/core/routes/appRouters.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/services/pdf_service.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DisplayBookBotton extends StatelessWidget {
  final ReadingProgressEntity progressEntity;

  const DisplayBookBotton({super.key, required this.progressEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (progressEntity.book?.fileUrl != null) {
          final pdfService = PdfService();
          final fileName = progressEntity.book!.fileUrl!.split('/').last;
          final file = await pdfService.downloadFile(
            progressEntity.book!.fileUrl!,
            fileName,
          );

          if (file != null && context.mounted) {
            GoRouter.of(context).push(
              Routes.pdfViewerPage,
              extra: {
                'filePath': file.path,
                'bookId': progressEntity.bookId,
                'userId': progressEntity.userId,
                'currentPage': progressEntity.currentPage,
                'book': progressEntity.book,
              },
            );
          } else {
             if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to download book")),
              );
            }
          }
        }
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          borderRadius: BorderRadius.circular(100),
        ),

        child: const Icon(Icons.play_arrow, color: AppColors.indigoDark),
      ),
    );
  }
}
