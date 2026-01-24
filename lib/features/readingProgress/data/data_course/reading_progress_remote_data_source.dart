import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/readingProgress/data/models/reading_progress_model.dart';

abstract class ReadingProgressRemoteDataSource {
  Future<void> updateProgress(ReadingProgressModel progress);
  Future<ReadingProgressModel?> getLastReadBook(int userId);
}

class ReadingProgressRemoteDataSourceImpl
    implements ReadingProgressRemoteDataSource {
  final ApiService apiService;

  ReadingProgressRemoteDataSourceImpl({required this.apiService});

  @override
  Future<void> updateProgress(ReadingProgressModel progress) async {
    final response = await apiService.post(
      endpoint: EndPoint.updateProgressEndpoint,
      data: progress.toJson(),
    );

    if (response['status'] == false) {
      throw ServerException(
        message: response['message'] ?? 'Failed to update progress',
      );
    }
  }

  @override
  Future<ReadingProgressModel?> getLastReadBook(int userId) async {
    try {
      final response = await apiService.get(
        endpoint: '${EndPoint.lastReadEndpoint}',
      );

    
      if (response == null) return null;

      final data = response['data'] ?? response;
      if (data == null) return null;

      return ReadingProgressModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
