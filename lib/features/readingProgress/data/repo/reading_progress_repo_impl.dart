import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/readingProgress/data/data_course/reading_progress_local_data_source.dart';
import 'package:clean_architecture/features/readingProgress/data/data_course/reading_progress_remote_data_source.dart';
import 'package:clean_architecture/features/readingProgress/data/models/reading_progress_model.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/repo/reading_progress_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

class ReadingProgressRepoImpl implements ReadingProgressRepo {
  final ReadingProgressRemoteDataSource remoteDataSource;
  final ReadingProgressLocalDataSource localDataSource;

  ReadingProgressRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  ResultFuture<void> saveProgress(ReadingProgressEntity progress) async {
    try {
      final progressModel = ReadingProgressModel.fromEntity(progress);

      // 1. ALWAYS save to local storage first (Zero Data Loss)
      await localDataSource.cacheItem(progressModel);

      // 2. Check internet connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        // Offline: We are done, data is safe locally.
        return const Right(null);
      }

      // 3. Online: Sync with backend
      await remoteDataSource.updateProgress(progressModel);
      return const Right(null);
    } catch (e) {
      // If remote sync fails, we still return success because local save succeeded.
      // Ideally, we might want to queue this for later sync.
      // For now, returning Right(null) is acceptable as user experience is preserved.
      return const Right(null);
    }
  }

  @override
  ResultFuture<ReadingProgressEntity?> getLastReadBook(int userId) async {

    // 1. Check internet connectivity
    final connectivityResult = await Connectivity().checkConnectivity();

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        // 2. Online: Try to fetch from API
        final remoteProgress = await remoteDataSource.getLastReadBook(userId);

        if (remoteProgress != null) {
          // 3. If successful, update local cache
          await localDataSource.cacheItem(remoteProgress);
          return Right(remoteProgress);
        }
      } catch (e) {
        // If remote fails, fall through to local
        print("🔴 Remote fetch or Cache save failed: $e");
      }
    }

    // 4. Offline or Remote Failed: Fetch from Local Storage
    try {
      final localProgress = await localDataSource.getCacheItem();

      if (localProgress == null) {
        return const Left(CacheFailure("No cached progress found"));
      }
      return Right(localProgress);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
