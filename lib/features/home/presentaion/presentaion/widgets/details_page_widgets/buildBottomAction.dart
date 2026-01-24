
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/services/pdf_service.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/widgets/buttons/custom_button.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildBottomAction extends StatefulWidget {
  const BuildBottomAction({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  State<BuildBottomAction> createState() => _BuildBottomActionState();
}

class _BuildBottomActionState extends State<BuildBottomAction> {
  bool _isLoading = false;

  Future<void> _handlePreview() async {
    
    if (widget.book.fileUrl == null || widget.book.fileUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No preview available for this book")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final pdfService = PdfService();
      // Extract filename from URL or use a default
      final fileName = widget.book.fileUrl?.split('/').last;
      
      final file = await pdfService.downloadFile("${widget.book.fileUrl}", fileName!);

      if (file != null) {
        if (mounted) {
          GoRouter.of(context).push(
            Routes.pdfViewerPage,
            extra: {
              'filePath': file.path,
              'bookId': int.tryParse(widget.book.bookId) ?? 0,
              'userId': AppConstants.userIdValue,
              'book': widget.book,
            },
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to download book preview")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.1),
            offset: const Offset(0, -5),
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // زر المعاينة
            Expanded(
              flex: 1,
              child: CustomButton(
                text: _isLoading ? "Loading..." : "Free Preview",
                textColor: AppColors.textPrimaryLight,
                color: AppColors.bgLight,
                onPressed: _isLoading ? () {} : _handlePreview,
                // يمكن تعديل الستايل ليكون Border فقط إذا أردت
              ),
            ),
            const SizedBox(width: 15),
            // زر الشراء
            Expanded(
              flex: 2,
              child: CustomButton(
                text:
                    widget.book.price == 0 || widget.book.price == null
                        ? "Download Now"
                        : "Buy for ${widget.book.price}\$",
                textColor: Colors.white,
                color: AppColors.primary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
