
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:flutter/material.dart';

class BuildTitleSection extends StatelessWidget {
  const BuildTitleSection({
    super.key,
    required this.book,
  });

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (book.categories?.isNotEmpty ?? false)
          Text(
            book.categories!.first.toUpperCase(),
            style: Styles.style12(context).copyWith(
              color: AppColors.indigo,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        const SizedBox(height: 8),
        Text(book.title, style: Styles.textStyle24.copyWith(height: 1.2)),
        if (book.subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            book.subtitle!,
            style: Styles.style16(context).copyWith(color: AppColors.grey400),
          ),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.grey400,
            ),
            const SizedBox(width: 5),
            Text(
              book.authors?.first ?? "Unknown Author",
              style: Styles.style14(context).copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
