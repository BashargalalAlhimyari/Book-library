import 'package:clean_architecture/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PdfViewerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isNightMode;
  final VoidCallback onSearchTap;
  final VoidCallback onNightModeTap;
  final VoidCallback onSaveTap;
  final String title;

  const PdfViewerAppBar({
    super.key,
    required this.isNightMode,
    required this.onSearchTap,
    required this.onNightModeTap,
    required this.onSaveTap,
    this.title = "قارئ الكتب",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppColors.primary,
      // أيقونات الإجراءات
      actions: [
        // 1. زر البحث
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchTap,
          tooltip: "بحث",
        ),
        
        // 2. زر الوضع الليلي (يتغير شكله)
        IconButton(
          icon: Icon(isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
          onPressed: onNightModeTap,
          tooltip: isNightMode ? "الوضع النهاري" : "الوضع الليلي",
        ),
        
        // 3. زر الحفظ
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: onSaveTap,
          tooltip: "حفظ التقدم",
        ),
      ],
    );
  }

  // هذا الجزء ضروري جداً لكي يعرف الـ Scaffold ارتفاع البار
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}