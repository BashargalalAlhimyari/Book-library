# Diff Details

Date : 2026-01-08 23:29:14

Directory c:\\Users\\Bashar Al-himyary\\Desktop\\All Project\\flutter\\clean_architecture\\lib\\core

Total : 87 files,  -1398 codes, 39 comments, -171 blanks, all -1530 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/books\_app.dart](/lib/books_app.dart) | Dart | -39 | -1 | -2 | -42 |
| [lib/core/common/enums/language\_type.dart](/lib/core/common/enums/language_type.dart) | Dart | 11 | 0 | 2 | 13 |
| [lib/core/common/enums/password\_strength.dart](/lib/core/common/enums/password_strength.dart) | Dart | 1 | 0 | 2 | 3 |
| [lib/core/common/type\_def/typesdef.dart](/lib/core/common/type_def/typesdef.dart) | Dart | 8 | 4 | 7 | 19 |
| [lib/core/constants/app/app\_constants.dart](/lib/core/constants/app/app_constants.dart) | Dart | 22 | 5 | 6 | 33 |
| [lib/core/constants/app/app\_strings.dart](/lib/core/constants/app/app_strings.dart) | Dart | 18 | 2 | 2 | 22 |
| [lib/core/constants/colors.dart](/lib/core/constants/colors.dart) | Dart | -2 | -1 | -2 | -5 |
| [lib/core/constants/constants.dart](/lib/core/constants/constants.dart) | Dart | -4 | 0 | -1 | -5 |
| [lib/core/constants/endpoints.dart](/lib/core/constants/endpoints.dart) | Dart | 1 | 1 | 0 | 2 |
| [lib/core/di/service\_locator.dart](/lib/core/di/service_locator.dart) | Dart | 41 | 8 | 8 | 57 |
| [lib/core/errors/exception.dart](/lib/core/errors/exception.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/errors/failure.dart](/lib/core/errors/failure.dart) | Dart | -47 | -2 | -6 | -55 |
| [lib/core/functions/app\_bloc\_providers.dart](/lib/core/functions/app_bloc_providers.dart) | Dart | -29 | 0 | -3 | -32 |
| [lib/core/functions/init\_app\_configs.dart](/lib/core/functions/init_app_configs.dart) | Dart | -15 | 0 | -1 | -16 |
| [lib/core/functions/init\_hive.dart](/lib/core/functions/init_hive.dart) | Dart | -7 | 0 | -1 | -8 |
| [lib/core/functions/save\_books.dart](/lib/core/functions/save_books.dart) | Dart | -6 | 0 | -2 | -8 |
| [lib/core/functions/setup\_service\_locator.dart](/lib/core/functions/setup_service_locator.dart) | Dart | -17 | 0 | -4 | -21 |
| [lib/core/l10n/app\_localizations.dart](/lib/core/l10n/app_localizations.dart) | Dart | 50 | 72 | 20 | 142 |
| [lib/core/l10n/app\_localizations\_ar.dart](/lib/core/l10n/app_localizations_ar.dart) | Dart | 10 | 3 | 5 | 18 |
| [lib/core/l10n/app\_localizations\_en.dart](/lib/core/l10n/app_localizations_en.dart) | Dart | 10 | 3 | 5 | 18 |
| [lib/core/l10n/locale\_cubit.dart](/lib/core/l10n/locale_cubit.dart) | Dart | 9 | 0 | 3 | 12 |
| [lib/core/network/dio\_error\_handler.dart](/lib/core/network/dio_error_handler.dart) | Dart | 34 | 2 | 8 | 44 |
| [lib/core/network/execute\_request.dart](/lib/core/network/execute_request.dart) | Dart | 1 | 8 | 1 | 10 |
| [lib/core/network/initial\_dio.dart](/lib/core/network/initial_dio.dart) | Dart | 26 | 4 | 3 | 33 |
| [lib/core/routes/appRouters.dart](/lib/core/routes/appRouters.dart) | Dart | 10 | 4 | 0 | 14 |
| [lib/core/routes/navigatorKey.dart](/lib/core/routes/navigatorKey.dart) | Dart | 2 | 0 | 2 | 4 |
| [lib/core/theme/animation.dart](/lib/core/theme/animation.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/app\_dimensions.dart](/lib/core/theme/app_dimensions.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/app\_shadows.dart](/lib/core/theme/app_shadows.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/colors.dart](/lib/core/theme/colors.dart) | Dart | 28 | 5 | 7 | 40 |
| [lib/core/theme/styles.dart](/lib/core/theme/styles.dart) | Dart | 49 | 4 | 7 | 60 |
| [lib/core/theme/theme.dart](/lib/core/theme/theme.dart) | Dart | 50 | 1 | 4 | 55 |
| [lib/core/utils/functions/app\_bloc\_providers.dart](/lib/core/utils/functions/app_bloc_providers.dart) | Dart | 33 | 0 | 3 | 36 |
| [lib/core/utils/functions/init\_app\_configs.dart](/lib/core/utils/functions/init_app_configs.dart) | Dart | 15 | 0 | 1 | 16 |
| [lib/core/utils/hive/init\_hive.dart](/lib/core/utils/hive/init_hive.dart) | Dart | 7 | 0 | 1 | 8 |
| [lib/core/utils/hive/save\_books.dart](/lib/core/utils/hive/save_books.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/core/utils/hive/token\_storage.dart](/lib/core/utils/hive/token_storage.dart) | Dart | 19 | 0 | 6 | 25 |
| [lib/core/utils/manager/locale\_cubit.dart](/lib/core/utils/manager/locale_cubit.dart) | Dart | -8 | 0 | -3 | -11 |
| [lib/core/utils/service\_locator.dart](/lib/core/utils/service_locator.dart) | Dart | -41 | -8 | -8 | -57 |
| [lib/core/utils/token\_storage.dart](/lib/core/utils/token_storage.dart) | Dart | -19 | 0 | -6 | -25 |
| [lib/core/utils/validations/app\_validation.dart](/lib/core/utils/validations/app_validation.dart) | Dart | 102 | 12 | 21 | 135 |
| [lib/core/utils/validations/validation\_pattern.dart](/lib/core/utils/validations/validation_pattern.dart) | Dart | 17 | 8 | 8 | 33 |
| [lib/core/widgets/buttons/custom\_button.dart](/lib/core/widgets/buttons/custom_button.dart) | Dart | 32 | 0 | 3 | 35 |
| [lib/core/widgets/custom\_button.dart](/lib/core/widgets/custom_button.dart) | Dart | -32 | 0 | -3 | -35 |
| [lib/features/auth/data/data\_sourse/auth\_remote\_data\_source.dart](/lib/features/auth/data/data_sourse/auth_remote_data_source.dart) | Dart | -34 | 0 | -6 | -40 |
| [lib/features/auth/data/models/auth\_model.dart](/lib/features/auth/data/models/auth_model.dart) | Dart | -21 | 0 | -4 | -25 |
| [lib/features/auth/data/repo/auth\_repo\_impl.dart](/lib/features/auth/data/repo/auth_repo_impl.dart) | Dart | -34 | 0 | -5 | -39 |
| [lib/features/auth/domain/entity/auth\_entity.dart](/lib/features/auth/domain/entity/auth_entity.dart) | Dart | -10 | 0 | -2 | -12 |
| [lib/features/auth/domain/entity/login\_entity.dart](/lib/features/auth/domain/entity/login_entity.dart) | Dart | -5 | 0 | -1 | -6 |
| [lib/features/auth/domain/entity/signup\_entity.dart](/lib/features/auth/domain/entity/signup_entity.dart) | Dart | -10 | 0 | -1 | -11 |
| [lib/features/auth/domain/repo/auth\_repo.dart](/lib/features/auth/domain/repo/auth_repo.dart) | Dart | -7 | 0 | -1 | -8 |
| [lib/features/auth/domain/user\_cases/login\_usecase.dart](/lib/features/auth/domain/user_cases/login_usecase.dart) | Dart | -18 | 0 | -6 | -24 |
| [lib/features/auth/domain/user\_cases/register\_usecase.dart](/lib/features/auth/domain/user_cases/register_usecase.dart) | Dart | -27 | 0 | -6 | -33 |
| [lib/features/auth/presentaion/manger/auth\_cubit.dart](/lib/features/auth/presentaion/manger/auth_cubit.dart) | Dart | -38 | 0 | -7 | -45 |
| [lib/features/auth/presentaion/manger/auth\_state.dart](/lib/features/auth/presentaion/manger/auth_state.dart) | Dart | -13 | 0 | -6 | -19 |
| [lib/features/auth/presentaion/views/login.dart](/lib/features/auth/presentaion/views/login.dart) | Dart | -205 | 0 | -7 | -212 |
| [lib/features/auth/presentaion/views/sign\_up.dart](/lib/features/auth/presentaion/views/sign_up.dart) | Dart | -220 | 0 | -8 | -228 |
| [lib/features/home/data/data\_sources/home\_local\_data\_source.dart](/lib/features/home/data/data_sources/home_local_data_source.dart) | Dart | -29 | 0 | -10 | -39 |
| [lib/features/home/data/data\_sources/remote\_data\_source.dart](/lib/features/home/data/data_sources/remote_data_source.dart) | Dart | -39 | 0 | -13 | -52 |
| [lib/features/home/data/models/books\_model/books\_model.dart](/lib/features/home/data/models/books_model/books_model.dart) | Dart | -48 | -1 | -5 | -54 |
| [lib/features/home/data/repos/home\_repo\_impl.dart](/lib/features/home/data/repos/home_repo_impl.dart) | Dart | -55 | 0 | -8 | -63 |
| [lib/features/home/domain/entity/book\_entity.dart](/lib/features/home/domain/entity/book_entity.dart) | Dart | -25 | -1 | -3 | -29 |
| [lib/features/home/domain/entity/book\_entity.g.dart](/lib/features/home/domain/entity/book_entity.g.dart) | Dart | -45 | -4 | -8 | -57 |
| [lib/features/home/domain/repos/home\_repo.dart](/lib/features/home/domain/repos/home_repo.dart) | Dart | -7 | 0 | -2 | -9 |
| [lib/features/home/domain/user\_cases/fetch\_books\_use\_case.dart](/lib/features/home/domain/user_cases/fetch_books_use_case.dart) | Dart | -14 | 0 | -5 | -19 |
| [lib/features/home/domain/user\_cases/fetch\_newest\_use\_case.dart](/lib/features/home/domain/user_cases/fetch_newest_use_case.dart) | Dart | -14 | -1 | -5 | -20 |
| [lib/features/home/presentaion/manager/featuredBooksCubit/books\_cubit.dart](/lib/features/home/presentaion/manager/featuredBooksCubit/books_cubit.dart) | Dart | -29 | 0 | -6 | -35 |
| [lib/features/home/presentaion/manager/featuredBooksCubit/books\_state.dart](/lib/features/home/presentaion/manager/featuredBooksCubit/books_state.dart) | Dart | -18 | 0 | -10 | -28 |
| [lib/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news\_books\_cubit.dart](/lib/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news_books_cubit.dart) | Dart | -25 | 0 | -5 | -30 |
| [lib/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news\_books\_state.dart](/lib/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news_books_state.dart) | Dart | -18 | 0 | -9 | -27 |
| [lib/features/home/presentaion/views/details\_page\_view.dart](/lib/features/home/presentaion/views/details_page_view.dart) | Dart | -151 | -1 | -11 | -163 |
| [lib/features/home/presentaion/views/home\_view.dart](/lib/features/home/presentaion/views/home_view.dart) | Dart | -11 | 0 | -3 | -14 |
| [lib/features/home/presentaion/views/widgets/appbar\_widget.dart](/lib/features/home/presentaion/views/widgets/appbar_widget.dart) | Dart | -35 | 0 | -5 | -40 |
| [lib/features/home/presentaion/views/widgets/best\_seller\_listview.dart](/lib/features/home/presentaion/views/widgets/best_seller_listview.dart) | Dart | -69 | 0 | -10 | -79 |
| [lib/features/home/presentaion/views/widgets/best\_seller\_listview\_consumer.dart](/lib/features/home/presentaion/views/widgets/best_seller_listview_consumer.dart) | Dart | -47 | 0 | -6 | -53 |
| [lib/features/home/presentaion/views/widgets/book\_column\_details.dart](/lib/features/home/presentaion/views/widgets/book_column_details.dart) | Dart | -36 | -1 | -9 | -46 |
| [lib/features/home/presentaion/views/widgets/book\_rating.dart](/lib/features/home/presentaion/views/widgets/book_rating.dart) | Dart | -17 | 0 | -2 | -19 |
| [lib/features/home/presentaion/views/widgets/home\_view\_body.dart](/lib/features/home/presentaion/views/widgets/home_view_body.dart) | Dart | -81 | -2 | -9 | -92 |
| [lib/features/home/presentaion/views/widgets/list\_view\_bloc\_consumer.dart](/lib/features/home/presentaion/views/widgets/list_view_bloc_consumer.dart) | Dart | -43 | -4 | -5 | -52 |
| [lib/features/home/presentaion/views/widgets/listview\_items.dart](/lib/features/home/presentaion/views/widgets/listview_items.dart) | Dart | -77 | -2 | -10 | -89 |
| [lib/features/splash/presentaion/views/spalsh\_view.dart](/lib/features/splash/presentaion/views/spalsh_view.dart) | Dart | -12 | 0 | -3 | -15 |
| [lib/features/splash/presentaion/views/widgets/sliding\_text.dart](/lib/features/splash/presentaion/views/widgets/sliding_text.dart) | Dart | -17 | 0 | -5 | -22 |
| [lib/features/splash/presentaion/views/widgets/splash\_view\_body.dart](/lib/features/splash/presentaion/views/widgets/splash_view_body.dart) | Dart | -57 | 0 | -9 | -66 |
| [lib/l10n/app\_localizations.dart](/lib/l10n/app_localizations.dart) | Dart | -50 | -72 | -20 | -142 |
| [lib/l10n/app\_localizations\_ar.dart](/lib/l10n/app_localizations_ar.dart) | Dart | -9 | -3 | -5 | -17 |
| [lib/l10n/app\_localizations\_en.dart](/lib/l10n/app_localizations_en.dart) | Dart | -9 | -3 | -5 | -17 |
| [lib/main.dart](/lib/main.dart) | Dart | -15 | 0 | -4 | -19 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details