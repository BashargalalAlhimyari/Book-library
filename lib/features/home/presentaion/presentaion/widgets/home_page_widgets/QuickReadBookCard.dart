import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuickReadCard extends StatefulWidget {
  const QuickReadCard({super.key, required this.books});
  final List<BookEntity> books;

  @override
  State<QuickReadCard> createState() => _QuickReadCardState();
}

class _QuickReadCardState extends State<QuickReadCard> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double containerHeight = 350;

    const int itemsPerPage = 3;
    final int totalPages = (widget.books.length / itemsPerPage).ceil();

    return SizedBox(
      height: containerHeight,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: totalPages,
        itemBuilder: (context, pageIndex) {
          final int firstItemIndex = pageIndex * itemsPerPage;
          final int secondItemIndex = firstItemIndex + 1;
          final int thirdItemIndex = secondItemIndex + 1;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- الكتاب الأول ---
              Expanded(child: BookListTile(book: widget.books[firstItemIndex])),

              const SizedBox(height: 5),

              // --- الكتاب الثاني ---
              if (secondItemIndex < widget.books.length)
                Expanded(
                  child: BookListTile(book: widget.books[secondItemIndex]),
                )
              else
                const Spacer(), // يحافظ على المساحة فارغة

              const SizedBox(height: 5),

              // --- الكتاب الثالث ---
              if (thirdItemIndex < widget.books.length)
                Expanded(
                  child: BookListTile(book: widget.books[thirdItemIndex]),
                )
              else
                const Spacer(), // يحافظ على المساحة فارغة
            ],
          );
        },
      ),
    );
  }
}

// ==========================================
// ويدجت التايل المعدلة (Custom Row)
// ==========================================
class BookListTile extends StatelessWidget {
  const BookListTile({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    // حذفنا ListTile واستخدمنا Container مع Row
    return GestureDetector(
      onTap: () {
        if (AppConstants.isMobile(context)) {
          GoRouter.of(context).push(Routes.detailsPage, extra: book);
        } else {
          context.read<SelectedBookCubit>().selectBook(book);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10), // هوامش جانبية
        padding: const EdgeInsets.all(8), // مسافة داخلية
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          // (اختياري) إضافة ظل خفيف
        ),
        child: Row(
          children: [
            // 1. الصورة بحجم مخصص وكبير
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: CachedNetworkImage(
                  imageUrl:
                      (book.images?.isNotEmpty ?? false)
                          ? book.images![0]
                          : "https://via.placeholder.com/150",
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  errorWidget:
                      (context, url, error) =>
                          const Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(width: 12), // مسافة بين الصورة والنص
            // 2. النصوص (العنوان والوصف)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // توسيط عمودي
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title ?? "بدون عنوان",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16, // كبرنا الخط قليلاً
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.description ?? "لا يوجد وصف",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // 3. الأيقونة في النهاية
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
