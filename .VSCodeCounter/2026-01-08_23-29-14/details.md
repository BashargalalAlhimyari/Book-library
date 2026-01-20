# Details

Date : 2026-01-08 23:29:14

Directory c:\\Users\\Bashar Al-himyary\\Desktop\\All Project\\flutter\\clean_architecture\\lib\\core

Total : 41 files,  831 codes, 161 comments, 201 blanks, all 1193 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/core/common/enums/language\_type.dart](/lib/core/common/enums/language_type.dart) | Dart | 11 | 0 | 2 | 13 |
| [lib/core/common/enums/password\_strength.dart](/lib/core/common/enums/password_strength.dart) | Dart | 1 | 0 | 2 | 3 |
| [lib/core/common/type\_def/typesdef.dart](/lib/core/common/type_def/typesdef.dart) | Dart | 8 | 4 | 7 | 19 |
| [lib/core/constants/app/app\_constants.dart](/lib/core/constants/app/app_constants.dart) | Dart | 22 | 5 | 6 | 33 |
| [lib/core/constants/app/app\_strings.dart](/lib/core/constants/app/app_strings.dart) | Dart | 18 | 2 | 2 | 22 |
| [lib/core/constants/assets.dart](/lib/core/constants/assets.dart) | Dart | 4 | 0 | 1 | 5 |
| [lib/core/constants/endpoints.dart](/lib/core/constants/endpoints.dart) | Dart | 12 | 1 | 4 | 17 |
| [lib/core/di/service\_locator.dart](/lib/core/di/service_locator.dart) | Dart | 41 | 8 | 8 | 57 |
| [lib/core/errors/exception.dart](/lib/core/errors/exception.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/errors/failure.dart](/lib/core/errors/failure.dart) | Dart | 10 | 0 | 2 | 12 |
| [lib/core/l10n/app\_localizations.dart](/lib/core/l10n/app_localizations.dart) | Dart | 50 | 72 | 20 | 142 |
| [lib/core/l10n/app\_localizations\_ar.dart](/lib/core/l10n/app_localizations_ar.dart) | Dart | 10 | 3 | 5 | 18 |
| [lib/core/l10n/app\_localizations\_en.dart](/lib/core/l10n/app_localizations_en.dart) | Dart | 10 | 3 | 5 | 18 |
| [lib/core/l10n/locale\_cubit.dart](/lib/core/l10n/locale_cubit.dart) | Dart | 9 | 0 | 3 | 12 |
| [lib/core/network/api\_service.dart](/lib/core/network/api_service.dart) | Dart | 21 | 1 | 10 | 32 |
| [lib/core/network/check\_internet.dart](/lib/core/network/check_internet.dart) | Dart | 5 | 0 | 2 | 7 |
| [lib/core/network/dio\_error\_handler.dart](/lib/core/network/dio_error_handler.dart) | Dart | 34 | 2 | 8 | 44 |
| [lib/core/network/execute\_request.dart](/lib/core/network/execute_request.dart) | Dart | 13 | 10 | 2 | 25 |
| [lib/core/network/initial\_dio.dart](/lib/core/network/initial_dio.dart) | Dart | 61 | 8 | 9 | 78 |
| [lib/core/routes/appRouters.dart](/lib/core/routes/appRouters.dart) | Dart | 39 | 4 | 3 | 46 |
| [lib/core/routes/authGuard.dart](/lib/core/routes/authGuard.dart) | Dart | 25 | 4 | 7 | 36 |
| [lib/core/routes/navigatorKey.dart](/lib/core/routes/navigatorKey.dart) | Dart | 2 | 0 | 2 | 4 |
| [lib/core/routes/paths\_routes.dart](/lib/core/routes/paths_routes.dart) | Dart | 7 | 0 | 3 | 10 |
| [lib/core/theme/animation.dart](/lib/core/theme/animation.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/app\_dimensions.dart](/lib/core/theme/app_dimensions.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/app\_shadows.dart](/lib/core/theme/app_shadows.dart) | Dart | 0 | 0 | 1 | 1 |
| [lib/core/theme/colors.dart](/lib/core/theme/colors.dart) | Dart | 28 | 5 | 7 | 40 |
| [lib/core/theme/styles.dart](/lib/core/theme/styles.dart) | Dart | 72 | 4 | 15 | 91 |
| [lib/core/theme/theme.dart](/lib/core/theme/theme.dart) | Dart | 50 | 1 | 4 | 55 |
| [lib/core/userCases/no\_param\_use\_case.dart](/lib/core/userCases/no_param_use_case.dart) | Dart | 5 | 0 | 2 | 7 |
| [lib/core/userCases/use\_case.dart](/lib/core/userCases/use_case.dart) | Dart | 5 | 0 | 2 | 7 |
| [lib/core/userCases/usecase.dart](/lib/core/userCases/usecase.dart) | Dart | 6 | 0 | 3 | 9 |
| [lib/core/utils/bloc\_observer.dart](/lib/core/utils/bloc_observer.dart) | Dart | 21 | 4 | 6 | 31 |
| [lib/core/utils/functions/app\_bloc\_providers.dart](/lib/core/utils/functions/app_bloc_providers.dart) | Dart | 33 | 0 | 3 | 36 |
| [lib/core/utils/functions/init\_app\_configs.dart](/lib/core/utils/functions/init_app_configs.dart) | Dart | 15 | 0 | 1 | 16 |
| [lib/core/utils/hive/init\_hive.dart](/lib/core/utils/hive/init_hive.dart) | Dart | 7 | 0 | 1 | 8 |
| [lib/core/utils/hive/save\_books.dart](/lib/core/utils/hive/save_books.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/core/utils/hive/token\_storage.dart](/lib/core/utils/hive/token_storage.dart) | Dart | 19 | 0 | 6 | 25 |
| [lib/core/utils/validations/app\_validation.dart](/lib/core/utils/validations/app_validation.dart) | Dart | 102 | 12 | 21 | 135 |
| [lib/core/utils/validations/validation\_pattern.dart](/lib/core/utils/validations/validation_pattern.dart) | Dart | 17 | 8 | 8 | 33 |
| [lib/core/widgets/buttons/custom\_button.dart](/lib/core/widgets/buttons/custom_button.dart) | Dart | 32 | 0 | 3 | 35 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)