
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/bannerDetails.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/coverImage.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/displayBookBotton.dart';
import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  const CardBody({
    super.key,
    required this.lastReadBook,
    required this.progressValue,
    required this.current,
    required this.total,
  });

  final ReadingProgressEntity lastReadBook;
  final double progressValue;
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- Book Cover Image ---
          CoverImage(lastReadBook: lastReadBook),
    
          const SizedBox(width: 20),
    
          // --- Text and Details ---
          Expanded(
            child: BannerDetails(lastReadBook: lastReadBook, progressValue: progressValue, current: current, total: total),
          ),
          DisplayBookBotton(progressEntity:lastReadBook ,),
        ],
      ),
    );
  }
}
