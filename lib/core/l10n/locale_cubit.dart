import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale( AppConstants.defaultLang)); // اللغة الافتراضية

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }
}
