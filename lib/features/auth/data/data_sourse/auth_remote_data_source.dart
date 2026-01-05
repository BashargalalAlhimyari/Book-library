import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({required String email, required String password});
  Future<AuthModel> register({required String username, required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<AuthModel> login({required String email, required String password}) async {
    final response = await apiService.post(
      endpoint: EndPoint.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );
    return AuthModel.fromJson(response);
  }

  @override
  Future<AuthModel> register({required String username, required String email, required String password}) async {
    final response = await apiService.post(
      endpoint: EndPoint.registerEndpoint,
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
    return AuthModel.fromJson(response);
  }
}
