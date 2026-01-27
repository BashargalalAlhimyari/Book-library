import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/network/dio_error_handler.dart';
import 'package:clean_architecture/features/search/data/data_source/remote_search_books.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:clean_architecture/features/search/domain/repo/search_book_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchBooksRepoImp extends SearchBooksRepo {
  final RemoteSearchBooks remoteSearchBooks;
  SearchBooksRepoImp({required this.remoteSearchBooks});

  @override
  ResultFuture<List<SearchBooksEntity>> fetchSearchBooks({
    int pageNumber = AppConstants.itemsPerPage,
    String? query,
  }) async {
    try {
      final response = await remoteSearchBooks.fetchSearchBooks(
        pageNumber: pageNumber,
        query: query??"",
      );
      return right(response);
    } catch (e) {
   if (e is ServerException) {
        return left(ServerFailure(e.message)); // رسالة الخطأ من الباك اند
      }

      if (e is DioException) {
        return left(DioErrorHandler.handle(e)); // رسالة خطأ الاتصال/السيرفر
      }
      
      return left(ServerFailure(e.toString()));    }
  }
}
