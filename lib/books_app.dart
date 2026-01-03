import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // تأكد من المسار
import 'core/utils/routes/appRouters.dart';
import 'core/utils/manager/locale_cubit.dart';
import 'core/functions/app_bloc_providers.dart'; // الملف الذي أنشأناه سابقاً

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
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            routerConfig: AppRouters.routers,
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: const Color(0xff100B20),
            ),
          );
        },
      ),
    );
  }
}