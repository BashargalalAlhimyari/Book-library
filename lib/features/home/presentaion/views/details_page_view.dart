import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/core/widgets/custom_button.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

import 'package:clean_architecture/features/home/presentaion/views/widgets/listview_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsPageView extends StatelessWidget {
  const DetailsPageView({super.key, required this.books});
  final BookEntity books;
  @override
  Widget build(BuildContext context) {
    List<BookEntity> relatedBooks = List.filled(10, books);
    print(books);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AppBarBookDetails(),
                  BookDetailsImage(imageUrl: books.image!),
                  SizedBox(height: 20),
                  Text(books.title, style: Styles.textStyle30),
                  SizedBox(height: 5),
                  Text(
                    books.descrption ?? "",
                    style: Styles.textStyle14,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${books.authOrName}",
                    style: Styles.textStyle18.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Removed rating as it is not available
                  if (books.categories != null && books.categories!.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: books.categories!
                          .map((category) => Chip(label: Text(category)))
                          .toList(),
                    ),
                  SizedBox(height: 20),

                  bookButton(),
                  Expanded(child: SizedBox(height: 20)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "related books ",
                      textAlign: TextAlign.left,
                      style: Styles.textStyle16,
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: CostumListViewItems(books: relatedBooks),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class bookButton extends StatelessWidget {
  const bookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            color: Colors.white,
            textColor: Colors.black,
            text: "Buy now",
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          CustomButton(
            color: const Color.fromARGB(255, 255, 117, 117),
            textColor: Colors.white,
            text: "Add to cart",
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookDetailsImage extends StatelessWidget {
  const BookDetailsImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill),
        ),
      ),
    );
  }
}

class AppBarBookDetails extends StatelessWidget {
  const AppBarBookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(Icons.cancel_outlined, size: 30),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
        ],
      ),
    );
  }
}
