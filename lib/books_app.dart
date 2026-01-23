import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/l10n/app_localizations.dart'; // تأكد من المسار
import 'core/routes/appRouters.dart';
import 'core/l10n/locale_cubit.dart';
import 'core/utils/functions/app_bloc_providers.dart';
import 'core/theme/theme.dart';

class MainBooksApp extends StatefulWidget {
  const MainBooksApp({super.key});

  @override
  State<MainBooksApp> createState() => _MainBooksAppState();
}

class _MainBooksAppState extends State<MainBooksApp> {
  late final List<BlocProvider> _providers;

  @override
  void initState() {
    super.initState();
    _providers = getAppBlocProviders();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Use the cached providers list
      providers: _providers,
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale(AppConstants.englishLang),
              Locale(AppConstants.arabicLang),
            ],
            routerConfig: AppRouters.routers,
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.lightTheme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
