import 'package:clean_architecture/core/widgets/loading/banner_shimmer.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/BannerCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bannercardconsumer extends StatelessWidget {
  const Bannercardconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. تقييد العرض: في الديسكتوب، لا نريد الكارد أن يأخذ عرض الشاشة بالكامل
    // نضعه في Center و ConstrainedBox
    return BlocConsumer<ReadingProgressCubit, ReadingProgressState>(
      builder: (context, state) {
        if (state is ReadingProgressLoading) {
          return const BannerShimmer();
        }
        if (state is ReadingProgressFailure) {
          return const Center(
            child: Icon(Icons.error, size: 50, color: Colors.yellow),
          );
        }
        if (state is ReadingProgressSuccess) {
          return BannerCard(lastReadBook: state.lastReadBook!);
        } else {
          return const BannerShimmer();
        }
      },
      listener: (context, state) {
        if (state is ReadingProgressFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
    );
  }
}
