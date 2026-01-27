import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/newsBooksCubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/sideBar.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/appbar_widget.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/NewBooksConsumer.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/QuickReadBooksConsumer.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedConsumer.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TrendingBooksConsumer.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/navigationBar.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/widget/BannerCardConsumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _HomePage();
}

class _HomePage extends State<MobileLayout> {
  // 1. تعريف المتحكم
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // 4. تنظيف الذاكرة
    _scrollController.dispose();
    super.dispose();
  }

  // 5. دالة الاستماع (نظيفة جداً الآن)
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // عند الوصول لـ 70% من الصفحة
    if (currentScroll >= 0.7 * maxScroll) {
      // نطلب المزيد من الكتب للقائمة العمودية (التي في الأسفل)
      context.read<NewsBooksCubit>().fetchNewsBooks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DesktopSideMenu(),
      bottomNavigationBar:
          AppConstants.isMobile(context) ? BuildBottomNav() : null,

      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: const [
          SliverToBoxAdapter(child: AppbarSection(isDark: true)),

          // Challenge Card
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            sliver: SliverToBoxAdapter(child: Bannercardconsumer()),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Text(" الكتب الأعلى تقييما", style: Styles.textStyle18),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            sliver: SliverToBoxAdapter(child: TopRatedConsumer()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Text(" الكتب  المجانية", style: Styles.textStyle18),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            sliver: SliverToBoxAdapter(child: TopRatedConsumer()),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Text(" الكتب الجديدة", style: Styles.textStyle18),
            ),
          ),
          SliverToBoxAdapter(child: Newbooksconsumer()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
              child: Text("للقراءة السريعة", style: Styles.textStyle18),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            sliver: SliverToBoxAdapter(child: Quickreadbooksconsumer()),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
              child: Text("ترند هذا الموسم  ", style: Styles.textStyle18),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            sliver: SliverToBoxAdapter(child: Trendingbooksconsumer()),
          ),
        ],
      ),
    );
  }
}
