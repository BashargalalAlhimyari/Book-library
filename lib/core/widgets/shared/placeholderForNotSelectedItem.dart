import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class PlaceholderForNotSelectedItem extends StatelessWidget {
  const PlaceholderForNotSelectedItem({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppColors.bgDark : AppColors.bgLight, // خلفية هادئة
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. دائرة خلفية ناعمة للأيقونة
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.indigo.withOpacity(0.1), // لون باهت جداً
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.menu_book_rounded, // أيقونة كتاب مفتوح
                  size: 80,
                  color: AppColors.indigo.withOpacity(0.5),
                ),
              ),

              const SizedBox(height: 20),

              // 2. العنوان الرئيسي
              Text(
                "لم يتم اختيار كتاب",
                style: Styles.style24(
                  context,
                ).copyWith(color: isDark ? Colors.white70 : Colors.grey[800]),
              ),

              const SizedBox(height: 10),

              // 3. النص التوجيهي
              Text(
                "اختر كتاباً من القائمة الجانبية\nلعرض التفاصيل الكاملة هنا",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,

                style: Styles.style16(context).copyWith(
                  color: Colors.grey,
                  height: 1.5, // تباعد أسطر مريح
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
