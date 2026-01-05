import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'receive timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'bad certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromRequest(
          e.response?.statusCode,
          e.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'request cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(message: 'connection error');
      case DioExceptionType.unknown:
        return ServerFailure(message: 'unknown');
    }
  }

  factory ServerFailure.fromRequest(int? statusCode, dynamic response) {
    if (statusCode == 400) {
      return ServerFailure(
        message: "your request was not found , please try later",
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        message: "there is a problem with the server , please try later",
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      // Handle different response structures if needed
      if (response is Map &&
          response['error'] != null &&
          response['error']['message'] != null) {
        return ServerFailure(message: response['error']['message']);
      }
      return ServerFailure(message: response.toString());
    } else {
      return ServerFailure(message: "there is an error , please try later");
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});

  // ignore: deprecated_member_use
}
