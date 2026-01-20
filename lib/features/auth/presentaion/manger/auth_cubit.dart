import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:clean_architecture/core/utils/hive/token_storage.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_architecture/features/auth/domain/user_cases/login_usecase.dart';
import 'package:clean_architecture/features/auth/domain/user_cases/register_usecase.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold((failure) => emit(AuthFailure(message: failure.message)), (
      user,
    ) async {
    

   
      await TokenStorage.saveToken(user.token);
      await CacheHelper.saveData(
        key: AppConstants.userName,
        value: user.username,
      );
      await CacheHelper.saveData(
        key: AppConstants.userId,
        value: user.id.toString(),
      );
      await CacheHelper.saveData(
        key: AppConstants.userEmail,
        value: user.email,
      );
      emit(AuthSuccess(user: user));
    });
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await registerUseCase(
      RegisterParams(username: username, email: email, password: password),
    );
    result.fold((failure) => emit(AuthFailure(message: failure.message)), (
      user,
    ) async {
      await TokenStorage.saveToken(user.token);
      emit(AuthSuccess(user: user));
    });
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    emit(AuthInitial());
  }
}
