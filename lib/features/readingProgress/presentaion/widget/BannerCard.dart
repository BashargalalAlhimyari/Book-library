import 'package:clean_architecture/features/home/presentaion/presentaion/manager/card_doted_cubit.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/bannerCardBody.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/dotttedIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCard extends StatelessWidget {
  final ReadingProgressEntity lastReadBook;

  const BannerCard({super.key, required this.lastReadBook});

  @override
  Widget build(BuildContext context) {
    // Calculate progress safely
    final int current = lastReadBook.currentPage ?? 0;
    final int total =
        (lastReadBook.book == null || lastReadBook.totalPages == 0)
            ? 1
            : lastReadBook.book?.pageCount ?? 0;
    final double progressValue = (current / total).clamp(0.0, 1.0);
   
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: SizedBox(
        height: 230,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  context.read<CardDotedCubit>().changeCardDoted(index);
                },
                // Assuming you might want to show more books later, strictly keeping 2 based on your code
                // But usually this should be 1 if you only pass one 'lastReadBook'
                itemCount: 2,
                itemBuilder:
                    (context, index) => CardBody(
                      lastReadBook: lastReadBook,
                      progressValue: progressValue,
                      current: current,
                      total: total,
                    ),
              ),
            ),

            // --- Dots Indicator ---
            const SizedBox(height: 10),
            DottedIndicator(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
