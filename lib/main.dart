import 'package:clean_architecture/books_app.dart';
import 'package:clean_architecture/core/utils/functions/init_app_configs.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppConfigs();
  runApp(const BooksApp());
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBooksApp();
  }
}
