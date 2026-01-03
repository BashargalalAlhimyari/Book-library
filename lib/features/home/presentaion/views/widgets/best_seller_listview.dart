import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/utils/routes/paths_routes.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/book_column_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class homeViewItem extends StatefulWidget {
  const homeViewItem({super.key, this.books});
  final List<BookEntity>? books;

  @override
  State<homeViewItem> createState() => _homeViewItemState();
}

class _homeViewItemState extends State<homeViewItem> {
 

  @override
  Widget build(BuildContext context) {
    print("✅ GET ${widget.books!.length} successful ====================");

    return Column(
      children: List.generate(
        widget.books!.length,
        (index) => InkWell(
          onTap: () {
            GoRouter.of(context).push(Routes.detailsPage, extra: widget.books?[index]);
          },
          child: ItemContent(widget: widget, index: index),
        ),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    super.key,
    required this.widget, required this.index,
  });

  final int index;
  final homeViewItem widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 125,
            child: AspectRatio(
              aspectRatio: 2.8 / 4,
              child: 
             Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl:
                        widget.books?[index].image ?? AppAssets.testImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Expanded(child: BookColumnDetailsWidget(books : widget.books , index : index)),
        ],
      ),
    );
  }
}
