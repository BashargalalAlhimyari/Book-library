import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';

abstract class SearchBooksRepo {
  ResultFuture<List<SearchBooksEntity>> fetchSearchBooks({int pageNumber=AppConstants.itemsPerPage , String query});
}
