import 'package:clean_architecture/core/constants/app/app_constants.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/userCases/use_case.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchNewestUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchNewestUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([int param = AppConstants.itemsPerPage]) async {
    // TODO: implement call
    return await homeRepo.fetchNewsBooks(pageNumber: param);
  }
}

class NoParam {}
