import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/bloc_observer.dart';
import '../utils/service_locator.dart';
import 'init_hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../features/home/domain/entity/book_entity.dart';

Future<void> initAppConfigs() async {
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter<BookEntity>(BookEntityAdapter());
   initHive();
}