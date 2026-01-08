import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/home/presentaion/manager/CardDotedCubit/cubit/card_doted_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/home_view_body.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/navigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BuildBottomNav(), body: MainView());
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "أهلاً، أحمد ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "ماذا ستقرأ اليوم؟",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: AppColors.indigo,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        isDark ? AppColors.surfaceDark : Colors.white,
                    shadowColor: Colors.black12,
                    elevation: 2,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Challenge Card
        SliverToBoxAdapter(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: PageView.builder(
                    onPageChanged: (int index) {
                      context.read<CardDotedCubit>().changeCardDoted(index);
                    },
                    itemCount: 2,
                    itemBuilder:
                        (context, index) => Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.indigo.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 80,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/images/test_image.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "استكمل القراءة",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      "أولاد حارتنا",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      "  نجيب محفوظ",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    LinearProgressIndicator(
                                      value: 0.8,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.2,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      minHeight: 6,
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "30% مكتمل",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "  •  120 من 350 صفحة",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
                BlocBuilder<CardDotedCubit, CardDotedState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 5,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.only(left: 5),
                            height: 8,
                            width:
                                context
                                            .read<CardDotedCubit>()
                                            .state
                                            .selectedIndex ==
                                        index
                                    ? 20
                                    : 7,
                            decoration: BoxDecoration(
                              color: AppColors.indigo,
                              borderRadius: BorderRadius.circular(50),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Section Title
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 30, 24, 15),
            child: Text(
              "جاري قراءتها",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),

        // Horizontal Book List
        SliverToBoxAdapter(
          child: SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildBookCard();
              },
            ),
          ),
        ),

        // More Sections...
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "الأكثر رواجاً",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 15),
                _buildListTile("مقدمة ابن خلدون", "ابن خلدون", "4.9", isDark),
                _buildListTile("فن اللامبالاة", "مارك مانسون", "4.7", isDark),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookCard() {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=300",
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "مقدمة ابن خلدون",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            "ابن خلدون",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    String title,
    String author,
    String rating,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&w=150",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  author,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
