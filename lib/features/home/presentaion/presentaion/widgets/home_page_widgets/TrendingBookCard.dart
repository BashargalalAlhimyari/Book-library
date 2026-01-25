import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Trendingbookcard extends StatelessWidget {
  const Trendingbookcard({super.key, this.books});
  final List<BookEntity>? books;

  @override
  Widget build(BuildContext context) {
    if (books == null || books!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Using ListView.separated for better performance than List.generate inside Column
    // shrinkWrap: true allows it to exist inside another ScrollView
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: books!.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return TrendingBookItem(book: books![index], index: index);
      },
    );
  }
}

class TrendingBookItem extends StatelessWidget {
  const TrendingBookItem({super.key, required this.book, required this.index});

  final BookEntity book;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (AppConstants.isMobile(context)) {
          // Pass the book object via extra
          GoRouter.of(context).push(Routes.detailsPage, extra: book);
          // Optional: Keep cubit update if needed for state consistency
          context.read<SelectedBookCubit>().selectBook(book);
        } else {
          context.read<SelectedBookCubit>().selectBook(book);
        }
      },
      child: Container(
        color: Colors.transparent, // Ensures the whole area is clickable
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. The Ranking Number (The "Juice" 🥤)
            // Displays #1, #2, etc. styled distinctly

            // 2. The Elevated Book Cover
            Hero(
              tag:
                  'book_cover_${book.id ?? index}', // Hero animation for smooth transition
              child: Container(
                height: 100, // Fixed height for consistency
                width: 70, // Fixed width based on aspect ratio
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Drop shadow
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl:
                        (book.images?.isNotEmpty ?? false)
                            ? book.images![0]
                            : AppAssets.testImage,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // 3. Details Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    book.title ?? "Unknown Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Author
                  Text(
                    book.authors?.first ?? "Unknown Author",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle14.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Metadata Row (Rating & Category)
                  Row(
                    children: [
                      // Rating Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${book.averageRating ?? "4.0"}", // You can map this to book.averageRating later
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[900],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Category Text
                      if (book.categories != null &&
                          book.categories!.isNotEmpty)
                        Flexible(
                          child: Text(
                            book.categories!.first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // 4. Action Icon (Bookmark)
            // Purely visual juice to balance the row
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.bookmark_border_rounded,
                color: Colors.grey[400],
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
