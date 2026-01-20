import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/assets.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/navigationCubit/navigate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DesktopSideMenu extends StatelessWidget {
  const DesktopSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor, // لون الخلفية
        border: Border(
          right: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ), // خط فاصل خفيف
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: ListView(
        children: [
          // 1️⃣ الشعار أو اسم التطبيق
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.indigo,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "BookStore",
                style: Styles.style24(
                  context,
                ).copyWith(fontSize: 22, color: AppColors.indigo),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // 2️⃣ بطاقة المستخدم المصغرة (لإعطاء فخامة للتصميم)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    AppAssets.testImage,
                  ), // صورة تجريبية
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${CacheHelper.getString(key: AppConstants.userName)}",
                      style: Styles.style14(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ),
                    Text(
                      "${CacheHelper.getString(key: AppConstants.userEmail) ?? "مستخدم زائر"}",
                      style: Styles.style12(
                        context,
                      ).copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 3️⃣ عناصر القائمة (مربوطة بالكيوبت)
          Text(
            "MENU",
            style: Styles.style12(
              context,
            ).copyWith(color: Colors.grey, letterSpacing: 1.5),
          ),
          const SizedBox(height: 10),

          const _SideMenuItem(
            icon: Icons.grid_view_rounded,
            label: "الرئيسية",
            index: 0,
          ),
          const _SideMenuItem(
            icon: Icons.search_rounded,
            label: "استكشف",
            index: 1,
          ),
          const _SideMenuItem(
            icon: Icons.bookmark_outline_rounded,
            label: "مكتبتي",
            index: 2,
          ),
          const _SideMenuItem(
            icon: Icons.person_outline_rounded,
            label: "الملف الشخصي",
            index: 3,
          ),

          const Spacer(), // يدفع العناصر التالية للأسفل
          // 4️⃣ عناصر سفلية إضافية
          const Divider(),
          const _SideMenuItem(
            icon: Icons.settings_outlined,
            label: "الإعدادات",
            index: 4,
          ), // يمكن جعل الاندكس خارج النطاق أو معالجته
          _SideMenuItem(
            icon: Icons.logout_rounded,
            label: "تسجيل خروج",
            index: 5,
            isDestructive: true,
            onPressed: () async {
              await context.read<AuthCubit>().logout();
              CacheHelper.removeData(key: AppConstants.userEmail);
              CacheHelper.removeData(key: AppConstants.userName);
              CacheHelper.removeData(key: AppConstants.userId);
              GoRouter.of(context).go(Routes.loginPage);
            },
          ),
        ],
      ),
    );
  }
}

class _SideMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isDestructive;
  final void Function()? onPressed;

  const _SideMenuItem({
    required this.icon,
    required this.label,
    required this.index,
    this.isDestructive = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // التحقق من العنصر النشط عبر الكيوبت
    return BlocBuilder<NavigateCubit, NavigateState>(
      builder: (context, state) {
        bool isActive = state.selectedIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () {
              // إذا كان زر خروج لا نغير الصفحة
              if (!isDestructive) {
                context.read<NavigateCubit>().moveToIndex(index);
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: isActive ? AppColors.indigo : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(icon: Icon(icon), onPressed: onPressed),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: Styles.style16(context).copyWith(
                      color:
                          isActive
                              ? Colors.white
                              : (isDestructive
                                  ? Colors.red
                                  : AppColors
                                      .textPrimaryLight), // تأكد من استخدام لون مناسب للوضع الداكن هنا
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
