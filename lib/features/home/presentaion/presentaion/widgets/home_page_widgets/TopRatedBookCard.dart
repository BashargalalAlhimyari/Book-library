import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Topratedbookcard extends StatefulWidget {
  const Topratedbookcard({super.key, required this.books});
  final List<BookEntity> books;

  @override
  State<Topratedbookcard> createState() =>
      _BuildHorizontalListviewCardState();
}

class _BuildHorizontalListviewCardState
    extends State<Topratedbookcard> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;

    // إذا وصلنا لـ 70% من القائمة
    if (currentPosition >= 0.7 * maxPosition) {
      context.read<TopRatedBooksCubit>().fetchTopRatedBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ التعديل الأول: الارتفاع نسبة مئوية (30%) من الشاشة وليس رقماً ثابتاً
    // هذا يضمن أن القائمة تكبر وتصغر مع الجهاز
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.books.length,
        itemBuilder: (context, index) {
          return BookCard(book: widget.books[index]);
        },
      ),
    );
  }
}

// ==========================================
// ويدجت الكارت (تم تحسينها لتكون متجاوبة)
// ==========================================
class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: Padding(
        padding: const EdgeInsets.only(right: 10), // مسافة جانبية بين الكتب
        child: Column(
          children: [
            // ✅ التعديل الثالث: نستخدم Expanded للصورة لكي تأخذ المساحة الأكبر
            Expanded(
              flex: 4, // الصورة تأخذ 4 أجزاء من المساحة
              child: InkWell(
                onTap: () {
                  // هنا يمكنك وضع شرط إذا كان موبايل أو ديسكتوب كما شرحت لك سابقاً
                  if (AppConstants.isMobile(context)) {
                    GoRouter.of(context).push(Routes.detailsPage, extra: book);
                  } else {
                    context.read<SelectedBookCubit>().selectBook(book);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl:
                        (book.images?.isNotEmpty ?? false)
                            ? book.images![0]
                            : AppAssets.testImage,
                    fit: BoxFit.fill,
                    width: double.infinity, // لكي تملأ عرض الـ AspectRatio
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // ✅ التعديل الرابع: النص يأخذ المساحة المتبقية فقط
            Expanded(
              flex: 1, // النص يأخذ جزءاً واحداً
              child: Text(
                book.authors?.first ?? "Unknown Author",
                style: Styles.style14(context),
                maxLines: 2, // نسمح بسطرين في حال كان الاسم طويلاً
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, // توسيط النص
              ),
            ),
          ],
        ),
      ),
    );
  }
}
