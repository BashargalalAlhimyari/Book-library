
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.lastReadBook,
  });

  final ReadingProgressEntity lastReadBook;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (AppConstants.isMobile(context)) {
          GoRouter.of(context).push(
            Routes.detailsPage,
            extra: lastReadBook.book,
          );
        } else {
          context.read<SelectedBookCubit>().selectBook(
            lastReadBook.book!,
          );
        }
      },
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            10,
          ), // Reduced radius slightly for inner image
          child: CachedNetworkImage(
            imageUrl:
                (lastReadBook.book?.images != null &&
                        lastReadBook
                            .book!
                            .images!
                            .isNotEmpty)
                    ? lastReadBook.book!.images![0]
                    : AppAssets.testImage,
            fit: BoxFit.fill,
            width: double.infinity,
            placeholder:
                (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
            errorWidget:
                (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
