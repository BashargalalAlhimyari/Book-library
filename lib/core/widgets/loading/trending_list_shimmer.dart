import 'package:clean_architecture/core/widgets/loading/shimmer_loading.dart';
import 'package:flutter/material.dart';

class TrendingListShimmer extends StatelessWidget {
  const TrendingListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5, // Show 5 shimmer items
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              SizedBox(
                height: 125,
                child: AspectRatio(
                  aspectRatio: 2.8 / 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: const ShimmerLoading(
                      width: double.infinity,
                      height: double.infinity,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 30),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerLoading(
                      width: 200,
                      height: 20,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const ShimmerLoading(
                      width: 150,
                      height: 14,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const ShimmerLoading(
                      width: 100,
                      height: 14,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
