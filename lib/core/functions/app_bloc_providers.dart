import 'package:clean_architecture/core/utils/service_locator.dart';
import 'package:clean_architecture/core/utils/manager/locale_cubit.dart';
import 'package:clean_architecture/features/home/data/repos/home_repo_impl.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_books_use_case.dart'
    show FetchBooksUseCase;
import 'package:clean_architecture/features/home/domain/user_cases/fetch_newest_use_case.dart'
    show FetchNewestUseCase;
import 'package:clean_architecture/features/home/presentaion/manager/featuredBooksCubit/books_cubit.dart';
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news_books_cubit.dart';

List<BlocProvider> getAppBlocProviders() {
  return [
    BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
    BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
    BlocProvider<BooksCubitDartCubit>(
      create:
          (context) =>
              BooksCubitDartCubit(FetchBooksUseCase(getIt.get<HomeRepoImpl>()))
                ..fetchFeatureBooks(),
    ),
    BlocProvider<NewsBooksCubit>(
      create:
          (context) => NewsBooksCubit(
            FetchNewestUseCase(homeRepo: getIt.get<HomeRepoImpl>()),
          )..fetchNewsBooks(),
    ),
  ];
}
