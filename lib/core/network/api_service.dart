import 'package:clean_architecture/core/network/execute_request.dart';
import 'package:clean_architecture/core/network/initial_dio.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  // 1. استخدام static const للروابط يجعل تعديلها أسهل ويفضل نقلها لملف constants

  ApiService(this._dio) {
    initialiseDio(this._dio);
  }


  Future<dynamic> get({required String endpoint, Map<String, dynamic>? query}) async {

    return performRequest(_dio.get(endpoint, queryParameters: query));
  }

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> data}) async {
    return performRequest(_dio.post(endpoint, data: data));
  }

  Future<dynamic> put({required String endpoint, required Map<String, dynamic> data}) async {
    return performRequest(_dio.put(endpoint, data: data));
  }

  Future<dynamic> delete({required String endpoint}) async {
    return performRequest(_dio.delete(endpoint));
  }


}