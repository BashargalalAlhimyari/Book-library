import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/utils/hive/hive_data.dart'
    as HiveData; // نستخدم alias لتجنب تداخل الأسماء
import 'package:clean_architecture/features/readingProgress/data/models/reading_progress_model.dart';

import '../../../../core/utils/hive/hive_data.dart';

abstract class ReadingProgressLocalDataSource {
  Future<void> cacheItem(ReadingProgressModel progress);
  Future<ReadingProgressModel?> getCacheItem();
}

class ReadingProgressLocalDataSourceImpl
    implements ReadingProgressLocalDataSource {
  @override
  Future<void> cacheItem(ReadingProgressModel progress) async {
    print("💾 Caching ReadingProgress: ${progress.book?.title}");
    await saveSingleItem<ReadingProgressModel>(progress, AppConstants.boxReadingProgress, "ReadingProgress");
    print("✅ Cached Successfully");
  }

  @override
  Future<ReadingProgressModel?> getCacheItem() async {
    final item = getSingleItem<ReadingProgressModel>(
      AppConstants.boxReadingProgress,
      "ReadingProgress",
    );
    print("📂 Retrieved from Cache: ${item?.book?.title}");
    return item;
  }
}
