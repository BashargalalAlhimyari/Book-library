import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Trendingbookcard extends StatefulWidget {
  const Trendingbookcard({super.key, this.books});
  final List<BookEntity>? books;

  @override
  State<Trendingbookcard> createState() =>
      _BuildVerticalListviewCardState();
}

class _BuildVerticalListviewCardState extends State<Trendingbookcard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.books!.length,
        (index) => InkWell(
          onTap: () {
            if (AppConstants.isMobile(context)) {
              
              GoRouter.of(
                context,
              ).push(Routes.detailsPage, extra: widget.books?[index]);
                context.read<SelectedBookCubit>().selectBook(
                widget.books![index],
              );
            } else {
              context.read<SelectedBookCubit>().selectBook(
                widget.books![index],
              );
            }
          },
          child: ItemContent(widget: widget, index: index),
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({super.key, required this.widget, required this.index});

  final int index;
  final Trendingbookcard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 125,
            child: AspectRatio(
              aspectRatio: 2.8 / 4,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl:
                        (widget.books?[index].images?.isNotEmpty ?? false)
                            ? widget.books![index].images![0]
                            : AppAssets.testImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: BookColumnDetailsWidget(
              books: widget.books?[index],
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}

class BookColumnDetailsWidget extends StatelessWidget {
  const BookColumnDetailsWidget({super.key, this.books, this.index});
  final BookEntity? books;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              "${books?.title} $index",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle18,
            ),
          ),
          const SizedBox(height: 3),

          Text("${books?.authors}", style: Styles.textStyle14),
          const SizedBox(height: 3),
          // Removed price and rating as they are not available in the new API
          if (books?.categories != null &&
              books?.categories!.isNotEmpty == true)
            Text(
              books?.categories!.join(', ') ?? '',
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
