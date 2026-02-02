import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:flutter/material.dart';

class BuildSearchBookCard extends StatelessWidget {
  const BuildSearchBookCard({super.key, required this.books});
  final List<SearchBooksEntity> books;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No books found",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _SearchBookItem(book: books[index]),
          );
        },
      ),
    );
  }
}

class _SearchBookItem extends StatelessWidget {
  const _SearchBookItem({required this.book});
  final SearchBooksEntity book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Selected: ${book.title}")));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120, // ارتفاع ثابت ومناسب للقائمة
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // 1. صورة الكتاب (على اليسار)
            SearchBookImage(book: book),

            // 2. تفاصيل الكتاب (على اليمين)
            SearchBookDetailsWidget(book: book),
          ],
        ),
      ),
    );
  }
}

class SearchBookImage extends StatelessWidget {
  const SearchBookImage({super.key, required this.book});

  final SearchBooksEntity book;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        bottomLeft: Radius.circular(12),
      ),
      child: SizedBox(
        width: 90, // عرض الصورة في القائمة
        height: double.infinity,
        child: CachedNetworkImage(
          imageUrl:
              (book.images.isNotEmpty)
                  ? book.images.first
                  : "https://via.placeholder.com/150",
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
          errorWidget:
              (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
        ),
      ),
    );
  }
}

class SearchBookDetailsWidget extends StatelessWidget {
  const SearchBookDetailsWidget({super.key, required this.book});

  final SearchBooksEntity book;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            if (book.authors.isNotEmpty)
              Text(
                book.authors.join(", "),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  book.price == 0 ? "Free" : "\$${book.price}",
                  style: const TextStyle(
                    color: Colors.amber, // لون السعر
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
