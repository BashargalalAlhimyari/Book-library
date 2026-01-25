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
  State<Topratedbookcard> createState() => _BuildHorizontalListviewCardState();
}

class _BuildHorizontalListviewCardState extends State<Topratedbookcard> {
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
    if (!scrollController.hasClients) return;
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;

    if (currentPosition >= 0.7 * maxPosition) {
      context.read<TopRatedBooksCubit>().fetchTopRatedBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. الحصول على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 2. حساب عرض الكارت وارتفاع القائمة بناءً على الجهاز
    double cardWidth;
    double listHeight;

    if (screenWidth < 600) {
      // موبايل: العرض 35% من الشاشة، الارتفاع 32% من الشاشة (لكن بحد أدنى وأقصى)
      cardWidth = screenWidth * 0.30;
      listHeight = (screenHeight * 0.28).clamp(240.0, 320.0);
    } else if (screenWidth < 900) {
      // تابلت: العرض 22%
      cardWidth = screenWidth * 0.17;
      listHeight = 300.0;
    } else {
      // ديسكتوب: عرض ثابت لمنع الصور العملاقة
      cardWidth = 200.0;
      listHeight = 380.0;
    }

    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ), // Vertical padding للظلال
        itemCount: widget.books.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          // نمرر العرض المحسوب للكارت
          return SizedBox(
            width: cardWidth,
            child: BookCard(book: widget.books[index]),
          );
        },
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    // نستخدم LayoutBuilder لمعرفة المساحة المتاحة داخل الكارت نفسه
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================== Image Section ==================
            // نستخدم Expanded لضمان أن الصورة تأخذ المساحة المتبقية ولا تضغط النص
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (AppConstants.isMobile(context)) {
                    GoRouter.of(context).push(Routes.detailsPage, extra: book);
                  } else {
                    context.read<SelectedBookCubit>().selectBook(book);
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand, // يملأ الصورة في المساحة المتاحة
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              (book.images?.isNotEmpty ?? false)
                                  ? book.images![0]
                                  : AppAssets.testImage,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(Icons.image, color: Colors.grey),
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
                        // Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.05),
                              ],
                            ),
                          ),
                        ),
                        // Rating Badge
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
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
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        Styles.style14(context).fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            SizedBox(
              height: 45, // نثبت ارتفاع منطقة النص لمنع اختلاف ارتفاع الكروت
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Title
                  Flexible(
                    child: Text(
                      book.title ?? "Unknown Title",
                      style: Styles.style16(context).copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: _getResponsiveFontSize(context, 14),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Author
                  Flexible(
                    child: Text(
                      book.authors?.first ?? "Unknown Author",
                      style: Styles.style14(context).copyWith(
                        color: Colors.grey[600],
                        fontSize: _getResponsiveFontSize(context, 12),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // دالة مساعدة صغيرة لضبط حجم الخط حسب الجهاز
  double _getResponsiveFontSize(BuildContext context, double fontSize) {
    double scaleFactor = MediaQuery.of(context).size.width / 400;
    if (MediaQuery.of(context).size.width > 900) {
      return fontSize * 1.1; // تكبير بسيط للديسكتوب
    }
    return (fontSize * scaleFactor).clamp(
      10.0,
      16.0,
    ); // حماية الخط من أن يكون صغيراً جداً أو كبيراً جداً
  }
}
