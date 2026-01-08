import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture/features/home/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> fetchBooks({
    int pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;
      // books = homeLocalDataSource.fetchBooks(pageNumber: pageNumber);
      // if (books.isNotEmpty) {
      //   return right(books);
      // }

      books = await homeRemoteDataSource.fetchBooks(pageNumber: pageNumber);
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks({
    int pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;
      // books = homeLocalDataSource.fetchNewsBooks(pageNumber: pageNumber);

      // if (books.isNotEmpty) {
      //   return right(books);
      // }
      books = await homeRemoteDataSource.fetchNewsBooks(pageNumber: pageNumber);
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
