import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({super.key, this.userName = "Ahmed Ali"});

  final String userName;

  @override
  Widget build(BuildContext context) {
    // 1. استخراج حالة الثيم تلقائياً
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. تحديد وقت اليوم للتحية
    final hour = DateTime.now().hour;
    final String greeting = hour < 12 ? 'Good Morning ☀️' : 'Good Evening 🌙';

    return Padding(
      // استخدام SafeArea أو Padding علوي يتناسب مع النتوء (Notch)
      padding: const EdgeInsets.fromLTRB(24, 50, 24, 10),
      child: Row(
        children: [
          // الجزء الأيسر: الترحيب والاسم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greeting,
                  style: Styles.style14(context).copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userName,
                  style: Styles.style18(context).copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // الجزء الأيمن: الأزرار
          _CircularActionButton(
            icon: Icons.search_rounded,
            onTap: () => GoRouter.of(context).push('/search'),
          ),
          const SizedBox(width: 12),
          _NotificationButton(onTap: () {}),
        ],
      ),
    );
  }
}

// ويدجت منفصل لزر الإشعارات مع النقطة الحمراء
class _NotificationButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NotificationButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        _CircularActionButton(
          icon: Icons.notifications_none_rounded,
          onTap: onTap,
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircularActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // لون خلفية الدائرة (يبقى شفافاً قليلاً ليعطي شكلاً عصرياً)
            color:
                isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
            border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
          ),
          child: Icon(
            icon,
            size: 26,
            // لون الأيقونة (يجب أن يكون صريحاً وبدون Opacity منخفض)
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
