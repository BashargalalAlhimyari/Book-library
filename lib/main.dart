import 'package:bloc/bloc.dart';
import 'package:clean_architecture/books_app.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/utils/bloc_observer.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:clean_architecture/core/utils/hive/init_hive.dart';
import 'package:clean_architecture/core/utils/hive/token_storage.dart';
import 'package:clean_architecture/features/home/data/models/books_model.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/readingProgress/data/models/reading_progress_model.dart';
import 'package:clean_architecture/features/search/data/models/search_books_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter<BooksModel>(BooksModelAdapter());
  Hive.registerAdapter<ReadingProgressModel>(ReadingProgressModelAdapter());
  await initHive();
  await TokenStorage.init();
  await CacheHelper.init();
  setupServiceLocator();

  //  await CacheHelper.init();
  //  HiveService.init();
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
// 1. Get the string first

// 2. Convert it to int safely
   return MainBooksApp();
  }
}
