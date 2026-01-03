import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  final Dio _dio;
  // Using localhost as requested. For Android Emulator use 10.0.2.2
  final String baseUrl = "http://10.36.84.22:3000/api"; 

  ApiService(this._dio) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<void> setToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get({required String endpoint, Map<String, dynamic>? queryParameters}) async {
    if (await _hasNoInternet()) {
      throw Exception("No internet connection");
    }
    var response = await _dio.get(endpoint, queryParameters: queryParameters);
    return response.data;
  }

  Future<dynamic> post({required String endpoint, required Map<String, dynamic> data}) async {
    if (await _hasNoInternet()) {
      throw Exception("No internet connection");
    }
    var response = await _dio.post(endpoint, data: data);
    return response.data;
  }

  Future<dynamic> put({required String endpoint, required Map<String, dynamic> data}) async {
    if (await _hasNoInternet()) {
      throw Exception("No internet connection");
    }
    var response = await _dio.put(endpoint, data: data);
    return response.data;
  }

  Future<dynamic> delete({required String endpoint}) async {
    if (await _hasNoInternet()) {
      throw Exception("No internet connection");
    }
    var response = await _dio.delete(endpoint);
    return response.data;
  }

  Future<bool> _hasNoInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.none);
  }
}