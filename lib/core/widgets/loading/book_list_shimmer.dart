import 'package:clean_architecture/core/widgets/loading/shimmer_loading.dart';
import 'package:flutter/material.dart';

class BookListShimmer extends StatelessWidget {
  const BookListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Approximate height of book card
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Cover
                ShimmerLoading(
                  width: 120,
                  height: 160,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(height: 8),
                // Title
                ShimmerLoading(
                  width: 100,
                  height: 14,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                SizedBox(height: 4),
                // Author/Subtitle
                ShimmerLoading(
                  width: 80,
                  height: 12,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
