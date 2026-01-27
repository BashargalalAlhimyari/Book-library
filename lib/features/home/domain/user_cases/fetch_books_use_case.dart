import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/userCases/use_case.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';

class FetchBooksUseCase extends UseCase<BooksList, int> {
  final HomeRepo _homeRepo;

    FetchBooksUseCase(this._homeRepo);

  @override
  ResultFuture<BooksList> call([int param = AppConstants.itemsPerPage]) async {
    return await _homeRepo.fetchBooks(pageNumber: param);
  }
}

class NoParam {}
