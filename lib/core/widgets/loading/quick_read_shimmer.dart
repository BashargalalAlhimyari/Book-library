import 'package:clean_architecture/core/widgets/loading/shimmer_loading.dart';
import 'package:flutter/material.dart';

class QuickReadShimmer extends StatelessWidget {
  const QuickReadShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildShimmerItem()),
          const SizedBox(height: 5),
          Expanded(child: _buildShimmerItem()),
          const SizedBox(height: 5),
          Expanded(child: _buildShimmerItem()),
        ],
      ),
    );
  }

  Widget _buildShimmerItem() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          // Image
          AspectRatio(
            aspectRatio: 2 / 3,
            child: ShimmerLoading(
              width: double.infinity,
              height: double.infinity,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
          SizedBox(width: 12),
          // Text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  width: 150,
                  height: 16,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                SizedBox(height: 8),
                ShimmerLoading(
                  width: 200,
                  height: 12,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
