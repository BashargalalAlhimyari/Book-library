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
import 'package:clean_architecture/features/home/domain/user_cases/fetch_books_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_newest_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_quick_read_books_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_top_rated_books_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_trending_books_use_case.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/quick_read_books_cubit/quick_read_books_cubit_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/newsBooksCubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/trendingBooks/trendin_books_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));

  // Features - Auth
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(loginUseCase: getIt(), registerUseCase: getIt()),
  );

  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  // Features - Home

  // 1. Data Sources
  getIt.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiService: getIt()),
  );

  // 2. Repository
  getIt.registerLazySingleton<HomeRepoImpl>(
    () => HomeRepoImpl(
      homeRemoteDataSource: getIt(),
      homeLocalDataSource: getIt(),
    ),
  );

  // 👇👇👇 هذا هو الجزء الذي كان ناقصاً وأضفته لك 👇👇👇

  // 3. Use Cases (يجب تسجيلها قبل الكيوبت)
  getIt.registerLazySingleton<FetchBooksUseCase>(
    // هنا نقول لـ GetIt: خذ الـ Repo المسجل وضعه داخل الـ UseCase
    () => FetchBooksUseCase(getIt<HomeRepoImpl>()),
  );






  getIt.registerLazySingleton<FetchNewestUseCase>(
    () => FetchNewestUseCase( getIt<HomeRepoImpl>()),
  );
  getIt.registerLazySingleton<FetchTopRatedBooksUseCase>(
    () => FetchTopRatedBooksUseCase( getIt<HomeRepoImpl>()),
  );
  getIt.registerLazySingleton<FetchTrendingBooksUseCase>(
    () => FetchTrendingBooksUseCase( getIt<HomeRepoImpl>()),
  );
  getIt.registerLazySingleton<FetchQuickReadBooksUseCase>(
    () => FetchQuickReadBooksUseCase( getIt<HomeRepoImpl>()),
  );



  // 👆👆👆 نهاية الجزء المضاف 👆👆👆

  // 4. Cubits (الآن الكيوبت سيجد الـ UseCase جاهزاً)
  getIt.registerLazySingleton<TopRatedBooksCubit>(
    () => TopRatedBooksCubit(getIt<FetchTopRatedBooksUseCase>()),
  );
  getIt.registerLazySingleton<NewsBooksCubit>(
    () => NewsBooksCubit(getIt<FetchNewestUseCase>()),
  );
  getIt.registerLazySingleton<TrendingBooksCubit>(
    () => TrendingBooksCubit(getIt<FetchTrendingBooksUseCase>()),
  );
  getIt.registerLazySingleton<QuickReadBooksCubit>(
    () => QuickReadBooksCubit(getIt<FetchQuickReadBooksUseCase>()),
  );
}
