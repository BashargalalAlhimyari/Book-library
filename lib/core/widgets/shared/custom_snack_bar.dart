import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    // إخفاء أي سناك بار سابق (لتجنب تراكم الرسائل)
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // 1. جعل الخلفية شفافة لنقوم نحن بتصميم الكونتينر الخاص بنا
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating, // يجعله يطوف فوق العناصر
        margin: const EdgeInsets.all(20), // مسافة من الحواف
        duration: const Duration(seconds: 3), // مدة الظهور
        
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            // اللون يتغير حسب نوع الرسالة (خطأ أو نجاح)
            color: isError ? AppColors.red : AppColors.indigo,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: (isError ? AppColors.red : AppColors.indigo).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10), // ظل ناعم للأسفل
              ),
            ],
          ),
          child: Row(
            children: [
              // 2. الأيقونة داخل دائرة شبه شفافة
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2), // زجاجي
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isError ? Icons.error_outline : Icons.waving_hand_rounded, // أيقونة ترحيب
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              
              // 3. النص
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isError ? "Oh Snap!" : "Welcome back!", // عنوان صغير
                      style: Styles.style12(context).copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: Styles.style14(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}