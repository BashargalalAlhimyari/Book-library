import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> fetchBooks({int pageNumber=0});
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks({int pageNumber = 0});
}
