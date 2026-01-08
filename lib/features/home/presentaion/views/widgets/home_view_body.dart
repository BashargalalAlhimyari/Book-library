import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/appbar_widget.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/best_seller_listview_consumer.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/list_view_bloc_consumer.dart';
import 'package:clean_architecture/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  ScrollController scrollController = ScrollController();
  int nextPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() async {
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;

    // جلب البيانات عند الوصول لـ 70% من القائمة
    if (currentPosition >= 0.7 * maxPosition) {
      if (!isLoading) {
        isLoading = true;
        try {
          await context.read<NewsBooksCubit>().fetchNewsBooks(pageNumber: nextPage++);
        } catch (e) {
          print(e);
        }
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWidget(),
        Expanded(
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listViewBlocConsumer(), // القائمة الأفقية (Featured Books)
                      SizedBox(height: 40),
                      Text(
                        AppLocalizations.of(context)!.bestSeller,
                        style: Styles.style18(context),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // القائمة الرأسية (Best Seller) توضع هنا مرة واحدة فقط
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(child: BestSellerListViewWidgets()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
