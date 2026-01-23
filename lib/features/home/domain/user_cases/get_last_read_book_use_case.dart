import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/repo/reading_progress_repo.dart';

import '../../../../core/userCases/usecase.dart';

class GetLastReadBookUseCase extends UseCase<ReadingProgressEntity?, int> {
  final ReadingProgressRepo repo;

  GetLastReadBookUseCase(this.repo);

  @override
  ResultFuture<ReadingProgressEntity?> call(int params) {
    return repo.getLastReadBook(params);
  }
}
