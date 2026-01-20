import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  AuthModelFuture login({required String email, required String password});
  AuthModelFuture register({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  AuthModelFuture login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      endpoint: EndPoint.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    return _handleResponse(response);
  }

  @override
  AuthModelFuture register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      endpoint: EndPoint.registerEndpoint,
      data: {'username': username, 'email': email, 'password': password},
    );
    return _handleResponse(response);
  }

  _handleResponse(dynamic data) {
   
    // التحقق من الحالة القادمة من السيرفر
    if (data['status'] == false) {
      throw ServerException(
        message: data['message'] ?? 'Unknown Error Occurred',
      );
    }

    // التحقق من وجود البيانات
    if (data['data'] != null) {

   
      return AuthModel.fromJson(data['data']);
    }

    return [];
  }
}
