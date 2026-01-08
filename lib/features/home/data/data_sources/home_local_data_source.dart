import 'package:clean_architecture/core/constants/app/app_constants.dart';
import 'package:clean_architecture/core/constants/constants.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchBooks({int pageNumber = 0});
  List<BookEntity> fetchNewsBooks({int pageNumber = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchBooks({int pageNumber = AppConstants.defaultPageNumber}) {
    var box = Hive.box<BookEntity>(keyFeaturedBox);

    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.values.length;

    if (startIndex >= length) return [];
    if (endIndex > length) endIndex = length;

    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchNewsBooks({int pageNumber = AppConstants.itemsPerPage}) {
   var box = Hive.box<BookEntity>(keyFeaturedNewsBox);

    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.values.length;

    if (startIndex >= length) return [];
    if (endIndex > length) endIndex = length;

    return box.values.toList().sublist(startIndex, endIndex);
  }
}
