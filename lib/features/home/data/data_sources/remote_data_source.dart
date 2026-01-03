import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/core/functions/save_books.dart';
import 'package:clean_architecture/features/home/data/models/books_model/books_model.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewsBooks({int pageNumber = 0});
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookEntity>> fetchBooks({int pageNumber = 0}) async {

    var data = await apiService.get(endpoint: "/books?page=$pageNumber&limit=10");

    List<BookEntity> books = getBooksList(data);

    saveBooks(books, keyFeaturedBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewsBooks({int pageNumber = 0}) async {
    var data = await apiService.get(
      endpoint: "/books?page=$pageNumber&limit=5",
    );
    List<BookEntity> books = getBooksList(data);
    saveBooks(books, keyFeaturedNewsBox);
    return books;
  }

  List<BookEntity> getBooksList(dynamic data) {
    List<BookEntity> books = [];

    if (data is List) {
      for (var bookMap in data) {
        books.add(BooksModel.fromJson(bookMap));
      }
    }

    return books;
  }
}
