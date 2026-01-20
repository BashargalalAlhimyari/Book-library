import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/userCases/use_case.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/repos/home_repo.dart';

class FetchNewestUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchNewestUseCase( this.homeRepo);

  @override
  ResultFuture<BooksList> call([int param = AppConstants.itemsPerPage]) async {
    // TODO: implement call
    return await homeRepo.fetchNewsBooks(pageNumber: param);
  }
}

class NoParam {}
