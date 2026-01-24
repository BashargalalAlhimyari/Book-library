import 'package:clean_architecture/core/utils/hive/init_hive.dart';
import 'package:clean_architecture/features/home/data/models/books_model.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    Hive.registerAdapter<BooksModel>(BooksModelAdapter());
    
    await Hive.initFlutter();
    await initHive();
  }
}
