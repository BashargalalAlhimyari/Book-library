import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

void initHive() async {
  await Hive.openBox<BookEntity>(keyFeaturedBox);
  await Hive.openBox<BookEntity>(keyFeaturedNewsBox);
}