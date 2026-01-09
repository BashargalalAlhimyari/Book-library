import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/l10n/app_localizations.dart'; // تأكد من المسار
import 'core/routes/appRouters.dart';
import 'core/l10n/locale_cubit.dart';
import 'core/utils/functions/app_bloc_providers.dart';
import 'core/theme/theme.dart';

class MainBooksApp extends StatelessWidget {
  const MainBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // هنا استدعينا الدالة الخارجية التي تحتوي على كل الـ Cubits
      providers: getAppBlocProviders(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: 'Bookly App',
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            routerConfig: AppRouters.routers,
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
