# Diff Details

Date : 2026-01-25 04:26:19

Directory c:\\Users\\Bashar Al-himyary\\Desktop\\All Project\\flutter\\clean_architecture\\lib

Total : 75 files,  1740 codes, 59 comments, 186 blanks, all 1985 lines

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [lib/books\_app.dart](/lib/books_app.dart) | Dart | 5 | 0 | 0 | 5 |
| [lib/core/constants/app\_constants.dart](/lib/core/constants/app_constants.dart) | Dart | 9 | 2 | 1 | 12 |
| [lib/core/constants/endpoints.dart](/lib/core/constants/endpoints.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/core/di/service\_locator.dart](/lib/core/di/service_locator.dart) | Dart | 33 | 9 | -3 | 39 |
| [lib/core/errors/failure.dart](/lib/core/errors/failure.dart) | Dart | 3 | 0 | 0 | 3 |
| [lib/core/l10n/locale\_cubit.dart](/lib/core/l10n/locale_cubit.dart) | Dart | -9 | 0 | -3 | -12 |
| [lib/core/network/api\_service.dart](/lib/core/network/api_service.dart) | Dart | 23 | 0 | -2 | 21 |
| [lib/core/network/execute\_request.dart](/lib/core/network/execute_request.dart) | Dart | 5 | 0 | 0 | 5 |
| [lib/core/routes/appRouters.dart](/lib/core/routes/appRouters.dart) | Dart | 14 | 0 | 0 | 14 |
| [lib/core/routes/paths\_routes.dart](/lib/core/routes/paths_routes.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/core/services/pdf\_service.dart](/lib/core/services/pdf_service.dart) | Dart | 36 | 1 | 9 | 46 |
| [lib/core/theme/styles.dart](/lib/core/theme/styles.dart) | Dart | 6 | 0 | 1 | 7 |
| [lib/core/utils/cubits/locale\_cubit.dart](/lib/core/utils/cubits/locale_cubit.dart) | Dart | 9 | 0 | 3 | 12 |
| [lib/core/utils/cubits/theme\_cubit.dart](/lib/core/utils/cubits/theme_cubit.dart) | Dart | 25 | 0 | 4 | 29 |
| [lib/core/utils/functions/app\_bloc\_providers.dart](/lib/core/utils/functions/app_bloc_providers.dart) | Dart | 15 | 0 | 0 | 15 |
| [lib/core/utils/hive/hive\_data.dart](/lib/core/utils/hive/hive_data.dart) | Dart | 31 | 5 | 7 | 43 |
| [lib/core/utils/hive/hive\_setup.dart](/lib/core/utils/hive/hive_setup.dart) | Dart | 1 | 0 | 0 | 1 |
| [lib/core/utils/hive/init\_hive.dart](/lib/core/utils/hive/init_hive.dart) | Dart | 2 | 0 | 0 | 2 |
| [lib/core/utils/hive/save\_books.dart](/lib/core/utils/hive/save_books.dart) | Dart | -7 | -3 | -3 | -13 |
| [lib/core/widgets/loading/banner\_shimmer.dart](/lib/core/widgets/loading/banner_shimmer.dart) | Dart | 18 | 0 | 3 | 21 |
| [lib/core/widgets/loading/book\_grid\_shimmer.dart](/lib/core/widgets/loading/book_grid_shimmer.dart) | Dart | 48 | 0 | 3 | 51 |
| [lib/core/widgets/loading/book\_list\_shimmer.dart](/lib/core/widgets/loading/book_list_shimmer.dart) | Dart | 48 | 3 | 3 | 54 |
| [lib/core/widgets/loading/quick\_read\_shimmer.dart](/lib/core/widgets/loading/quick_read_shimmer.dart) | Dart | 64 | 2 | 4 | 70 |
| [lib/core/widgets/loading/shimmer\_loading.dart](/lib/core/widgets/loading/shimmer_loading.dart) | Dart | 39 | 0 | 6 | 45 |
| [lib/core/widgets/loading/trending\_list\_shimmer.dart](/lib/core/widgets/loading/trending_list_shimmer.dart) | Dart | 68 | 2 | 3 | 73 |
| [lib/core/widgets/shared/placeholderForNotSelectedItem.dart](/lib/core/widgets/shared/placeholderForNotSelectedItem.dart) | Dart | 3 | 0 | 2 | 5 |
| [lib/core/widgets/shared/textFormField.dart](/lib/core/widgets/shared/textFormField.dart) | Dart | -31 | -11 | -6 | -48 |
| [lib/features/home/data/data\_sources/home\_local\_data\_source.dart](/lib/features/home/data/data_sources/home_local_data_source.dart) | Dart | -18 | -1 | -11 | -30 |
| [lib/features/home/data/models/books\_model.dart](/lib/features/home/data/models/books_model.dart) | Dart | 178 | 9 | 24 | 211 |
| [lib/features/home/data/models/books\_model.g.dart](/lib/features/home/data/models/books_model.g.dart) | Dart | 66 | 4 | 8 | 78 |
| [lib/features/home/data/models/books\_model/books\_model.dart](/lib/features/home/data/models/books_model/books_model.dart) | Dart | -101 | -9 | -12 | -122 |
| [lib/features/home/domain/entity/book\_entity.dart](/lib/features/home/domain/entity/book_entity.dart) | Dart | -11 | -1 | 2 | -10 |
| [lib/features/home/domain/entity/book\_entity.g.dart](/lib/features/home/domain/entity/book_entity.g.dart) | Dart | -63 | -4 | -8 | -75 |
| [lib/features/home/presentaion/presentaion/manager/CardDotedCubit/card\_doted\_cubit.dart](/lib/features/home/presentaion/presentaion/manager/CardDotedCubit/card_doted_cubit.dart) | Dart | -9 | 0 | -4 | -13 |
| [lib/features/home/presentaion/presentaion/manager/CardDotedCubit/card\_doted\_state.dart](/lib/features/home/presentaion/presentaion/manager/CardDotedCubit/card_doted_state.dart) | Dart | -8 | 0 | -5 | -13 |
| [lib/features/home/presentaion/presentaion/manager/card\_doted\_cubit.dart](/lib/features/home/presentaion/presentaion/manager/card_doted_cubit.dart) | Dart | 7 | 1 | 2 | 10 |
| [lib/features/home/presentaion/presentaion/manager/navigate\_cubit.dart](/lib/features/home/presentaion/presentaion/manager/navigate_cubit.dart) | Dart | 8 | 0 | 5 | 13 |
| [lib/features/home/presentaion/presentaion/manager/navigationCubit/navigate\_cubit.dart](/lib/features/home/presentaion/presentaion/manager/navigationCubit/navigate_cubit.dart) | Dart | -9 | 0 | -5 | -14 |
| [lib/features/home/presentaion/presentaion/manager/navigationCubit/navigate\_state.dart](/lib/features/home/presentaion/presentaion/manager/navigationCubit/navigate_state.dart) | Dart | -8 | 0 | -4 | -12 |
| [lib/features/home/presentaion/presentaion/manager/selected\_book\_cubit.dart](/lib/features/home/presentaion/presentaion/manager/selected_book_cubit.dart) | Dart | 0 | -1 | 0 | -1 |
| [lib/features/home/presentaion/presentaion/screens/details\_page.dart](/lib/features/home/presentaion/presentaion/screens/details_page.dart) | Dart | 19 | -2 | -4 | 13 |
| [lib/features/home/presentaion/presentaion/screens/layouts/mobile\_layout.dart](/lib/features/home/presentaion/presentaion/screens/layouts/mobile_layout.dart) | Dart | 24 | 0 | 1 | 25 |
| [lib/features/home/presentaion/presentaion/screens/pdf\_viewer\_page.dart](/lib/features/home/presentaion/presentaion/screens/pdf_viewer_page.dart) | Dart | 284 | 19 | 21 | 324 |
| [lib/features/home/presentaion/presentaion/screens/sideBar.dart](/lib/features/home/presentaion/presentaion/screens/sideBar.dart) | Dart | 12 | -1 | 1 | 12 |
| [lib/features/home/presentaion/presentaion/widgets/appbar\_widget.dart](/lib/features/home/presentaion/presentaion/widgets/appbar_widget.dart) | Dart | 62 | -12 | -2 | 48 |
| [lib/features/home/presentaion/presentaion/widgets/details\_page\_widgets/buildBottomAction.dart](/lib/features/home/presentaion/presentaion/widgets/details_page_widgets/buildBottomAction.dart) | Dart | 57 | 1 | 8 | 66 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/BannerCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/BannerCard.dart) | Dart | -156 | -14 | -9 | -179 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/NewBookCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/NewBookCard.dart) | Dart | 19 | 3 | 2 | 24 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/NewBooksConsumer.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/NewBooksConsumer.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/QuickReadBookCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/QuickReadBookCard.dart) | Dart | 139 | 11 | 20 | 170 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/QuickReadBooksConsumer.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/QuickReadBooksConsumer.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/QuickReadCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/QuickReadCard.dart) | Dart | -110 | -9 | -12 | -131 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/TopRatedBookCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedBookCard.dart) | Dart | 125 | 5 | 6 | 136 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/TopRatedConsumer.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedConsumer.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/TrendingBookCard.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/TrendingBookCard.dart) | Dart | 69 | 14 | 6 | 89 |
| [lib/features/home/presentaion/presentaion/widgets/home\_page\_widgets/TrendingBooksConsumer.dart](/lib/features/home/presentaion/presentaion/widgets/home_page_widgets/TrendingBooksConsumer.dart) | Dart | -1 | 0 | 0 | -1 |
| [lib/features/readingProgress/data/data\_course/reading\_progress\_local\_data\_source.dart](/lib/features/readingProgress/data/data_course/reading_progress_local_data_source.dart) | Dart | 27 | 0 | 5 | 32 |
| [lib/features/readingProgress/data/data\_course/reading\_progress\_remote\_data\_source.dart](/lib/features/readingProgress/data/data_course/reading_progress_remote_data_source.dart) | Dart | 39 | 0 | 11 | 50 |
| [lib/features/readingProgress/data/models/reading\_progress\_model.dart](/lib/features/readingProgress/data/models/reading_progress_model.dart) | Dart | 79 | 2 | 14 | 95 |
| [lib/features/readingProgress/data/models/reading\_progress\_model.g.dart](/lib/features/readingProgress/data/models/reading_progress_model.g.dart) | Dart | 48 | 4 | 8 | 60 |
| [lib/features/readingProgress/data/repo/reading\_progress\_repo\_impl.dart](/lib/features/readingProgress/data/repo/reading_progress_repo_impl.dart) | Dart | 56 | 12 | 13 | 81 |
| [lib/features/readingProgress/domain/entity/reading\_progress\_entity.dart](/lib/features/readingProgress/domain/entity/reading_progress_entity.dart) | Dart | 21 | 0 | 4 | 25 |
| [lib/features/readingProgress/domain/repo/reading\_progress\_repo.dart](/lib/features/readingProgress/domain/repo/reading_progress_repo.dart) | Dart | 6 | 0 | 2 | 8 |
| [lib/features/readingProgress/domain/useCase/get\_last\_read\_book\_use\_case.dart](/lib/features/readingProgress/domain/useCase/get_last_read_book_use_case.dart) | Dart | 12 | 0 | 5 | 17 |
| [lib/features/readingProgress/domain/useCase/save\_reading\_progress\_use\_case.dart](/lib/features/readingProgress/domain/useCase/save_reading_progress_use_case.dart) | Dart | 12 | 0 | 5 | 17 |
| [lib/features/readingProgress/presentaion/manager/reading\_progress/reading\_progress\_cubit.dart](/lib/features/readingProgress/presentaion/manager/reading_progress/reading_progress_cubit.dart) | Dart | 32 | 4 | 8 | 44 |
| [lib/features/readingProgress/presentaion/manager/reading\_progress/reading\_progress\_state.dart](/lib/features/readingProgress/presentaion/manager/reading_progress/reading_progress_state.dart) | Dart | 13 | 0 | 6 | 19 |
| [lib/features/readingProgress/presentaion/widget/BannerCard.dart](/lib/features/readingProgress/presentaion/widget/BannerCard.dart) | Dart | 47 | 4 | 6 | 57 |
| [lib/features/readingProgress/presentaion/widget/BannerCardConsumer.dart](/lib/features/readingProgress/presentaion/widget/BannerCardConsumer.dart) | Dart | 39 | 2 | 3 | 44 |
| [lib/features/readingProgress/presentaion/widget/bannerCardBody.dart](/lib/features/readingProgress/presentaion/widget/bannerCardBody.dart) | Dart | 50 | 2 | 9 | 61 |
| [lib/features/readingProgress/presentaion/widget/bannerDetails.dart](/lib/features/readingProgress/presentaion/widget/bannerDetails.dart) | Dart | 76 | 4 | 11 | 91 |
| [lib/features/readingProgress/presentaion/widget/coverImage.dart](/lib/features/readingProgress/presentaion/widget/coverImage.dart) | Dart | 62 | 0 | 5 | 67 |
| [lib/features/readingProgress/presentaion/widget/displayBookBotton.dart](/lib/features/readingProgress/presentaion/widget/displayBookBotton.dart) | Dart | 53 | 0 | 6 | 59 |
| [lib/features/readingProgress/presentaion/widget/dotttedIndicator.dart](/lib/features/readingProgress/presentaion/widget/dotttedIndicator.dart) | Dart | 31 | 0 | 2 | 33 |
| [lib/main.dart](/lib/main.dart) | Dart | 3 | 2 | 1 | 6 |

[Summary](results.md) / [Details](details.md) / [Diff Summary](diff.md) / Diff Details