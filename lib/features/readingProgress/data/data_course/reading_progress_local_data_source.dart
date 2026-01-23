import 'dart:convert';
import 'package:clean_architecture/features/readingProgress/data/models/reading_progress_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReadingProgressLocalDataSource {
  Future<void> cacheLastReadBook(ReadingProgressModel progress);
  Future<ReadingProgressModel?> getLastReadBook();
}

class ReadingProgressLocalDataSourceImpl implements ReadingProgressLocalDataSource {
  static const String CACHED_READING_PROGRESS = "CACHED_READING_PROGRESS";

  @override
  Future<void> cacheLastReadBook(ReadingProgressModel progress) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(progress.toJson());
    await prefs.setString(CACHED_READING_PROGRESS, jsonString);
  }

  @override
  Future<ReadingProgressModel?> getLastReadBook() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(CACHED_READING_PROGRESS);
    
    if (jsonString != null) {
      return ReadingProgressModel.fromJson(json.decode(jsonString));
    }
    return null;
  }
}
