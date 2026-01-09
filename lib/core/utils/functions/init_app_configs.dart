import 'package:clean_architecture/core/utils/token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc_observer.dart';
import '../../di/service_locator.dart';
import 'init_hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../features/home/domain/entity/book_entity.dart';

Future<void> initAppConfigs() async {
  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter<BookEntity>(BookEntityAdapter());
  await TokenStorage.init();
  await initHive();
}