import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewBookPaginatedGrid extends StatelessWidget {
  const NewBookPaginatedGrid({super.key, required this.books});
  final List<BookEntity> books;

  // إعدادات الشبكة

  @override
  Widget build(BuildContext context) {
    // 1. حساب عدد العناصر في الصفحة الواحدة
    final int itemsPerPage =
        AppConstants.getGridViewRows(context) *
        AppConstants.getGridViewColumns(context);

    final int totalPages = (books.length / itemsPerPage).ceil();

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
              crossAxisCount: AppConstants.getGridViewColumns(
                context,
              ), // عدد الأعمدة (3)
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
          borderRadius: BorderRadius.circular(12),
          // ظل للكارد بالكامل ليعطيه بروز
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // ClipRRect لقص الصورة والظل والنص داخل الحواف الدائرية
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand, // يجعل الصورة تملأ المساحة بالكامل
            children: [
              // 1. الصورة (في الخلفية)
              CachedNetworkImage(
                imageUrl:
                    (book.images?.isNotEmpty ?? false)
                        ? book.images![0]
                        : "https://via.placeholder.com/150",
                fit: BoxFit.cover, // Cover أفضل لملء الفراغ بدون تمطيط
                placeholder:
                    (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
              ),

              // 2. طبقة التدرج اللوني (Gradient Overlay)
              // هذه الطبقة ضرورية جداً لكي يظهر النص الأبيض بوضوح
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60, // ارتفاع الظل
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8), // أسود غامق في الأسفل
                        Colors.transparent, // شفاف في الأعلى
                      ],
                    ),
                  ),
                ),
              ),

              // 3. النص (فوق التدرج)
              Positioned(
                bottom: 8, // مسافة من الأسفل
                left: 8, // مسافة من اليسار
                right: 8, // مهم جداً: يمنع النص من الخروج عن الإطار يميناً
                child: Text(
                  book.title ?? "عنوان غير معروف",
                  maxLines: 1, // سطرين كحد أقصى
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center, // توسيط النص (اختياري)
                  style: Styles.style12(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2, // تباعد أسطر مريح
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
