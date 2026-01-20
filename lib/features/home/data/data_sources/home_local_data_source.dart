import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/utils/hive/save_books.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  // دوال القراءة (موجودة لديك)
  List<BookEntity> fetchBooks({int pageNumber = 0});
  List<BookEntity> fetchNewsBooks({int pageNumber = 0});
  List<BookEntity> fetchTrendingBooks({int pageNumber = 0});
  List<BookEntity> fetchTopRatedBooks({int pageNumber = 0});
  List<BookEntity> fetchQuickReadBooks({int pageNumber = 0});

  // ✅ دوال الحفظ (يجب إضافتها ليختفي الخطأ في الريبو)
  Future<void> cacheBooks(List<BookEntity> books);
  Future<void> cacheNewsBooks(List<BookEntity> books);
  Future<void> cacheTrendingBooks(List<BookEntity> books);
  Future<void> cacheTopRatedBooks(List<BookEntity> books);
  Future<void> cacheQuickReadBooks(List<BookEntity> books);
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchBooks({int pageNumber = 0}) {
    return _getPaginatedData(AppConstants.boxFeaturedBooks, pageNumber);
  }
  @override
  List<BookEntity> fetchNewsBooks({int pageNumber = 0}) {
    return _getPaginatedData(AppConstants.boxFeaturedNewsBox, pageNumber);
  }
  @override
  List<BookEntity> fetchTrendingBooks({int pageNumber = 0}) {
    return _getPaginatedData(AppConstants.boxFeaturedTrendinBooks, pageNumber);
  }
   @override
  List<BookEntity> fetchQuickReadBooks({int pageNumber = 0}) {
    return _getPaginatedData(AppConstants.boxFeaturedQuickReadBooks, pageNumber);
  }
  @override
  List<BookEntity> fetchTopRatedBooks({int pageNumber = 0}) {
    return _getPaginatedData(AppConstants.boxFeaturedTopRatedBooks, pageNumber);
  }

  // ✅ تنفيذ دالة حفظ الكتب المميزة
  @override
  Future<void> cacheBooks(List<BookEntity> books) async {
    // saveBooks دالة خارجية قمت باستيرادها، نستخدم await لضمان الحفظ
   await saveBooks(books, AppConstants.boxFeaturedBooks);
  }
  @override
  Future<void> cacheTrendingBooks(List<BookEntity> books) async {
    // saveBooks دالة خارجية قمت باستيرادها، نستخدم await لضمان الحفظ
    await saveBooks(books, AppConstants.boxFeaturedTrendinBooks);
  }

  @override
  Future<void> cacheNewsBooks(List<BookEntity> books) async {
    await saveBooks(books, AppConstants.boxFeaturedNewsBox);
  }
  @override
  Future<void> cacheTopRatedBooks(List<BookEntity> books) async {
    await saveBooks(books, AppConstants.boxFeaturedTopRatedBooks);
  }
   @override
  Future<void> cacheQuickReadBooks(List<BookEntity> books)async {   
     await saveBooks(books, AppConstants.boxFeaturedQuickReadBooks);

  }

  // دالة المساعدة (ممتازة، اتركها كما هي)
  List<BookEntity> _getPaginatedData(String boxName, int pageNumber) {
    if (!Hive.isBoxOpen(boxName)) {
      return [];
    }

    var box = Hive.box<BookEntity>(boxName);

    final int limit = AppConstants.itemsPerPage;

    int startIndex = pageNumber * limit;
    int endIndex = startIndex + limit;

    if (startIndex >= box.length) {
      return [];
    }

    if (endIndex > box.length) {
      endIndex = box.length;
    }

    return box.values.toList().sublist(startIndex, endIndex);
  }
  
 
  
 
}