import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';

abstract class HomeRepo {
  ResultFuture<BooksList> fetchBooks({int pageNumber=AppConstants.itemsPerPage});
  ResultFuture<BooksList> fetchNewsBooks({int pageNumber = AppConstants.itemsPerPage});
  ResultFuture<BooksList> fetchTrendingBooks({int pageNumber = AppConstants.itemsPerPage});
  ResultFuture<BooksList> fetchTopRatedBooks({int pageNumber = AppConstants.itemsPerPage});
  ResultFuture<BooksList> fetchQuickReadBooks({int pageNumber = AppConstants.itemsPerPage});
}
