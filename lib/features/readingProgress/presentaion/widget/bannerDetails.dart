import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:flutter/material.dart';

class BannerDetails extends StatelessWidget {
  const BannerDetails({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Continue Reading", // Translated "استكمل القراءة"
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),

        // Title
        Text(
          lastReadBook.book?.title ?? "Unknown Title",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),

        // Author
        Text(
          (lastReadBook.book?.authors != null &&
                  lastReadBook.book!.authors!.isNotEmpty)
              ? lastReadBook.book!.authors![0]
              : "Unknown Author",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const Spacer(),

        // Progress Bar
        LinearProgressIndicator(
          value: progressValue,
          backgroundColor: Colors.white24,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          minHeight: 6,
        ),
        const SizedBox(height: 8),

        // Page Count Details
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${(progressValue * 100).toInt()}% Done",
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Flexible(
              child: Text(
                "${lastReadBook.currentPage} of ${lastReadBook.book?.pageCount ?? 0} pages",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
