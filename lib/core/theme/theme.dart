import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class ThemeApp {
  static const String fontFamily = 'Readex Pro';

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.indigo,
        scaffoldBackgroundColor: AppColors.bgLight,
        colorScheme: const ColorScheme.light(
          primary: AppColors.indigo,
          secondary: AppColors.indigo,
          surface: AppColors.surfaceLight,
        ),
        fontFamily: fontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondaryLight,
          ),
        ),
      );

  // ثيم الوضع المظلم
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.indigo,
        scaffoldBackgroundColor: AppColors.bgDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.indigo,
          secondary: AppColors.indigo,
          surface: AppColors.surfaceDark,
        ),
        fontFamily: fontFamily,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryDark,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondaryDark,
          ),
        ),
      );
}
