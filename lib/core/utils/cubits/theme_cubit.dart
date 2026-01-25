import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _getThemeFromCache();
  }

  void changeTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    CacheHelper.saveData(
      key: AppConstants.isDark,
      value: state == ThemeMode.dark,
    );
  }

  void _getThemeFromCache() {
    final isDark = CacheHelper.getBool(key: AppConstants.isDark);
    if (isDark != null) {
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      emit(ThemeMode.light); // القيمة الافتراضية
    }
  }
}
