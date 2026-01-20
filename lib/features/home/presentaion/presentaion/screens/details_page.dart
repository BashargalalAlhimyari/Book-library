import 'dart:ui';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/details_page_widgets/buildBottomAction.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/details_page_widgets/buildCategories.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/details_page_widgets/buildSliverAppBar.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/details_page_widgets/buildStatItem.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/details_page_widgets/buildTitleSection.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedBookCard.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final BookEntity book;

  const DetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // تجهيز قائمة الكتب المقترحة
    List<BookEntity> relatedBooks = List.filled(5, book);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ✅ 1. شريط سفلي ثابت لسهولة الوصول لأزرار الشراء
      bottomNavigationBar: BuildBottomAction(book: book,),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ✅ 2. رأس الصفحة المتحرك مع تأثير الضباب
          BuildSliverAppBar(book: book),
          // ✅ 3. محتوى الصفحة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTitleSection(book: book),
                  const SizedBox(height: 20),
                  _buildStatsRow(context),
                  const SizedBox(height: 24),
                  if (book.description != null) ...[
                    Text("Description", style: Styles.style18(context)),
                    const SizedBox(height: 8),
                    Text(
                      book.description!,
                      style: Styles.style14(context).copyWith(
                        color: AppColors.textSecondaryLight,
                        height: 1.6, // تباعد الأسطر للقراءة المريحة
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (book.categories != null) BuildCategories(book: book),
                  const SizedBox(height: 30),
                  Text("You might also like", style: Styles.style18(context)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    child: Topratedbookcard(books: relatedBooks),
                  ),
                  const SizedBox(height: 20), // مساحة إضافية في الأسفل
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= قسم الهيدر (صورة الغلاف) =================

  // ================= قسم العنوان والمؤلف =================

  // ================= قسم الإحصائيات (السعر، التقييم) =================
  Widget _buildStatsRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.surfaceDark
                : AppColors.grey50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // التقييم
          BuildStatItem(context: context, icon: Icons.star_rounded, iconColor: AppColors.amber, value: "${book.averageRating ?? 0}", label: "Rating"),
          _buildDivider(),
          // عدد الصفحات (أو عدد التقييمات)
          BuildStatItem(context: context, icon: Icons.people_outline, iconColor: AppColors.primary, value: "${book.ratingCount ?? 0}", label: "Reviews"),
          _buildDivider(),
          // السعر
          BuildStatItem(context: context, icon: Icons.attach_money, iconColor: AppColors.green, value: book.price != null && book.price != 0
                    ? "${book.price}"
                    : "Free", label: "Price"),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: AppColors.grey300);
  }

}

