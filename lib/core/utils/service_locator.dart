import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/auth/data/data_sourse/auth_remote_data_source.dart';
import 'package:clean_architecture/features/auth/data/repo/auth_repo_impl.dart';
import 'package:clean_architecture/features/auth/domain/repo/auth_repo.dart';
import 'package:clean_architecture/features/auth/domain/user_cases/login_usecase.dart';
import 'package:clean_architecture/features/auth/domain/user_cases/register_usecase.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture/features/home/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));

  // Features - Auth
  // Bloc
  getIt.registerFactory<AuthCubit>(() => AuthCubit(
        loginUseCase: getIt(),
        registerUseCase: getIt(),
      ));

    // Use Cases
    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
    getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));

  // Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));


  // Features - Home
  getIt.registerLazySingleton<HomeLocalDataSource>(
      () => HomeLocalDataSourceImpl());
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(apiService: getIt()));
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl(
        homeRemoteDataSource: getIt(),
        homeLocalDataSource: getIt(),
      ));
}
