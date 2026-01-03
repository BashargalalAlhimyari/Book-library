import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture/features/home/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiService: ApiService(Dio()),
      ),
    ),
  );
}
