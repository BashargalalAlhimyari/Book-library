import 'package:clean_architecture/core/constants/app/app_constants.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> fetchBooks({int pageNumber=AppConstants.itemsPerPage});
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks({int pageNumber = AppConstants.itemsPerPage});
}
