import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/userCases/use_case.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo _homeRepo;

  FetchBooksUseCase(this._homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([int param = 0]) async {
    return await _homeRepo.fetchBooks(pageNumber: param);
  }
}

class NoParam {}
