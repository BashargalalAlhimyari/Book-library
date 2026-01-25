import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // تحديد وقت اليوم للتحية
    final hour = DateTime.now().hour;
    final String greeting = hour < 12 ? 'Good Morning ☀️' : 'Good Evening 🌙';

    return Padding(
      // Top 60 is good for spacing below status bar on modern phones
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ==============================
          // 1. الجزء الأيسر: الترحيب والاسم
          // ==============================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greeting,
                  style: Styles.style14(
                    context,
                  ).copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  "Ahmed Ali", // يمكن استبدالها باسم المستخدم من الـ Cubit
                  style: Styles.style18(context).copyWith(
                    fontWeight: FontWeight.bold,
                    // استخدام لون يتناسب مع الثيم
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ==============================
          // 2. الجزء الأيمن: الأزرار (بحث + إشعارات)
          // ==============================
          Row(
            children: [
              // --- زر البحث (Search Icon) ---
              _buildCircularIconButton(
                context,
                icon: Icons.search_rounded,
                onTap: () {
                  // GoRouter.of(context).push('/search');
                },
              ),

              const SizedBox(width: 12),

              // --- زر الإشعارات (Notification with Badge) ---
              Stack(
                alignment: Alignment.topRight,
                children: [
                  _buildCircularIconButton(
                    context,
                    icon: Icons.notifications_none_rounded,
                    onTap: () {},
                  ),
                  // The Red Dot (Juice 🥤)
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              // (اختياري) إذا أردت إضافة صورة بروفايل بدلاً من الإشعارات
              /*
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage("URL_HERE"),
              )
              */
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widget لرسم الأزرار الدائرية بشكل أنيق وموحد
  Widget _buildCircularIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          // لون خلفية خفيف جداً للأزرار
          color:
              isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.black12,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 24,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
