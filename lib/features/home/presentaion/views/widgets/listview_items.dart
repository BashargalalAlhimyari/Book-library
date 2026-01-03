import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/utils/routes/paths_routes.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/manager/featuredBooksCubit/books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class CostumListViewItems extends StatefulWidget {
  const CostumListViewItems({super.key, required this.books});
  // final String image;
  final List<BookEntity>? books;

  @override
  State<CostumListViewItems> createState() => _CostumListViewItemsState();
}

class _CostumListViewItemsState extends State<CostumListViewItems> {
  ScrollController scrollController = ScrollController();

  int nextPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() async {
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;

    if (currentPosition >= 0.7 * maxPosition) {
      if (!isLoading) {
        isLoading = true;
        try {
          await BlocProvider.of<BooksCubitDartCubit>(
            context,
          ).fetchFeatureBooks(pageNumber: nextPage++);

          print('nextPage: $nextPage');
        } catch (e) {
          print(e);
        }
        isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.books?.length,
        itemBuilder:
            (context, index) => AspectRatio(
              aspectRatio: 2.9 / 4,
              child: InkWell(
                onTap: () {
                  print(widget.books?[index].authOrName);
                  GoRouter.of(
                    context,
                  ).push(Routes.detailsPage, extra: widget.books?[index]);
                },
                child: Container(
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
      ),
    );
  }
}
