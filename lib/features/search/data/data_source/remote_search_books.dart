import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/errors/exception.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/search/data/models/search_books_model.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';

abstract class RemoteSearchBooks {
  Future<List<SearchBooksEntity>> fetchSearchBooks({int pageNumber = AppConstants.itemsPerPage ,  String query} );
}
class RemoteSearchBooksImp extends RemoteSearchBooks{
final ApiService apiService;

  RemoteSearchBooksImp({required this.apiService});
  @override
  Future<List<SearchBooksEntity>> fetchSearchBooks({int pageNumber = AppConstants.itemsPerPage ,  String? query})async {
 final response = await apiService.get(endpoint: EndPoint.searchBooks, query:{'page': pageNumber, 'limit': AppConstants.itemsPerPage, 'q': query},);
    return _handleResponse(response);
  }

  
 List<SearchBooksEntity> _handleResponse(dynamic data) {
    
    // التحقق من الحالة القادمة من السيرفر
    if (data['status'] == false) {
      throw ServerException(
        message: data['message'] ?? 'Unknown Error Occurred',
      );
    }

    // التحقق من وجود البيانات
    if (data['data'] != null && data['data'] is List) {
      // استخدام map بدلاً من for-loop لسرعة وكفاءة أعلى
      return List<SearchBooksEntity>.from(
        (data['data'] as List).map((e) => SearchBooksModel.fromJson(e)),
      );
    }

    return [];
  }
  
}