import 'package:clean_architecture/core/theme/colors.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  // Headlines
  static const textStyle40 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Titles & Body
  static const textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Captions & Small Text
  static const textStyle13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const textStyle12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const textStyle11 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
  );

  // Helper methods for dynamic coloring
  static TextStyle style30(BuildContext context) {
    return textStyle30.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight,
    );
  }

  static TextStyle style18(BuildContext context) {
    return textStyle18.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight,
    );
  }

  static TextStyle style14(BuildContext context) {
    return textStyle14.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight,
    );
  }
  
  static TextStyle style12(BuildContext context) {
    return textStyle12.copyWith(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.textSecondaryDark
          : AppColors.textSecondaryLight,
    );
  }
}
