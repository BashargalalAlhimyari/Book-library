import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/routes/appRouters.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewBookPaginatedGrid extends StatelessWidget {
  const NewBookPaginatedGrid({super.key, required this.books});
  final List<BookEntity> books;

  // إعدادات الشبكة
  final int rows = 3; // عدد الصفوف المطلوبة
  final int columns = 3; // عدد الأعمدة المطلوبة

  @override
  Widget build(BuildContext context) {
    // 1. حساب عدد العناصر في الصفحة الواحدة
    final int itemsPerPage = rows * columns;

    // 2. حساب العدد الكلي للصفحات
    // (مثلاً لو عندنا 20 كتاب، والصفحة تسع 9، سنحتاج 3 صفحات)
    final int totalPages = (books.length / itemsPerPage).ceil();

    // تحديد ارتفاع مناسب للـ PageView ليتسع للـ 3 صفوف
    // يمكنك تعديل هذا الارتفاع حسب حجم بطاقة الكتاب الذي تريده
    final double containerHeight = MediaQuery.of(context).size.height * 0.4;

    if (books.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("لا توجد كتب")),
      );
    }

    return AspectRatio(
      aspectRatio: 9 / 10,
      child: PageView.builder(
        itemCount: totalPages,
        scrollDirection: Axis.horizontal,
        // physics: const BouncingScrollPhysics(), // اختياري: لإضافة تأثير ارتداد
        itemBuilder: (context, pageIndex) {
          // 4. حساب بداية ونهاية الكتب لهذه الصفحة المحددة
          final int startIndex = pageIndex * itemsPerPage;
          // نستخدم min للتأكد من أننا لا نتجاوز عدد الكتب الكلي في آخر صفحة
          final int endIndex =
              (startIndex + itemsPerPage < books.length)
                  ? startIndex + itemsPerPage
                  : books.length;

          // 5. قص القائمة الرئيسية لأخذ كتب هذه الصفحة فقط
          final List<BookEntity> pageBooks = books.sublist(
            startIndex,
            endIndex,
          );

          // 6. بناء الشبكة لهذه الصفحة
          return GridView.builder(
            // مهم جداً: منع الـ GridView من السكرول لأنه داخل PageView
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns, // عدد الأعمدة (3)
              childAspectRatio: 0.9, // نسبة العرض للطول (تحكم في شكل البطاقة)
              crossAxisSpacing: 10, // مسافة أفقية بين الكتب
              mainAxisSpacing: 10, // مسافة عمودية بين الكتب
            ),
            itemCount: pageBooks.length,
            itemBuilder: (context, index) {
              return BookCardGridItem(book: pageBooks[index]);
            },
          );
        },
      ),
    );
  }
}

// تصميم بطاقة الكتاب المناسب للشبكة
class BookCardGridItem extends StatelessWidget {
  const BookCardGridItem({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (AppConstants.isMobile(context)) {
          GoRouter.of(context).push(Routes.detailsPage, extra: book);
        } else {
          context.read<SelectedBookCubit>().selectBook(book);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الصورة
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      (book.images?.isNotEmpty ?? false)
                          ? book.images![0]
                          : "https://via.placeholder.com/150", // صورة افتراضية
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            // العنوان
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title ?? "بدون عنوان",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
