import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';

abstract class ReadingProgressRepo {
  ResultFuture<void> saveProgress(ReadingProgressEntity progress);
  ResultFuture<ReadingProgressEntity?> getLastReadBook(int userId);
}
