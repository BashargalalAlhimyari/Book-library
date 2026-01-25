import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/utils/cubits/locale_cubit.dart';
import 'package:clean_architecture/core/utils/cache/shared_pref.dart';
import 'package:clean_architecture/core/utils/cubits/theme_cubit.dart';
import 'package:clean_architecture/features/home/data/repos/home_repo_impl.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_books_use_case.dart'
    show FetchBooksUseCase;
import 'package:clean_architecture/features/home/domain/user_cases/fetch_newest_use_case.dart'
    show FetchNewestUseCase;
import 'package:clean_architecture/features/auth/presentaion/manger/auth_cubit.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_top_rated_books_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_trending_books_use_case.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/card_doted_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/quick_read_books_cubit/quick_read_books_cubit_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/newsBooksCubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/trendingBooks/trendin_books_cubit.dart';
import 'package:clean_architecture/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';

import 'package:clean_architecture/features/home/presentaion/presentaion/manager/navigate_cubit.dart';

List<BlocProvider> getAppBlocProviders() {
  return [
    BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
    BlocProvider<CardDotedCubit>(create: (context) => CardDotedCubit()),
    BlocProvider<NavigateCubit>(create: (context) => NavigateCubit()),
    BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
    BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
    BlocProvider<SelectedBookCubit>(
      create: (context) => getIt<SelectedBookCubit>(),
    ),

    BlocProvider<TopRatedBooksCubit>(
      create:
          (context) => getIt.get<TopRatedBooksCubit>()..fetchTopRatedBooks(),
    ),
    BlocProvider<NewsBooksCubit>(
      create: (context) => getIt.get<NewsBooksCubit>()..fetchNewsBooks(),
    ),
    BlocProvider<TrendingBooksCubit>(
      create:
          (context) => getIt.get<TrendingBooksCubit>()..fetchTrendingBooks(),
    ),
    BlocProvider<QuickReadBooksCubit>(
      create: (context) => getIt.get<QuickReadBooksCubit>()..fetchQuickBooks(),
    ),
    BlocProvider<ReadingProgressCubit>(
      create:
          (context) =>
              getIt.get<ReadingProgressCubit>()
                ..fetchLastReadBook(AppConstants.userIdValue),
    ),
  ];
}
