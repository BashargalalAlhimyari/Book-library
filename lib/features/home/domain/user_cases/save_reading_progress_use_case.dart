import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/repo/reading_progress_repo.dart';

import '../../../../core/userCases/usecase.dart';

class SaveReadingProgressUseCase extends UseCase<void, ReadingProgressEntity> {
  final ReadingProgressRepo repo;

  SaveReadingProgressUseCase(this.repo);

  @override
  ResultFuture<void> call(ReadingProgressEntity params) {
    return repo.saveProgress(params);
  }
}
