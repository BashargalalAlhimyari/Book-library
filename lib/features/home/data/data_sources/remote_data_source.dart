import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/errors/exception.dart'; // تأكد من اسم الملف الصحيح (exception او exceptions)
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:clean_architecture/features/home/data/models/books_model/books_model.dart';

// 1. الواجهة (Interface) يجب أن تكون واضحة ومحددة
abstract class HomeRemoteDataSource {
  Future<List<BooksModel>> fetchBooks({required int pageNumber});
  Future<List<BooksModel>> fetchNewsBooks({required int pageNumber});
  Future<List<BooksModel>> fetchTopRatedBooks({required int pageNumber});
  Future<List<BooksModel>> fetchTrendingdBooks({required int pageNumber});
  Future<List<BooksModel>> fetchQuickReadBooks({required int pageNumber});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BooksModel>> fetchBooks({required int pageNumber}) async {
    final response = await apiService.get(
      endpoint: EndPoint.trendingBooksEndpoint,
      query: {'page': pageNumber, 'limit': AppConstants.itemsPerPage},
    );

    return _handleResponse(response);
  }
  @override
  Future<List<BooksModel>> fetchTrendingdBooks({required int pageNumber}) async {
    final response = await apiService.get(
      endpoint: EndPoint.trendingBooksEndpoint,
      query: {'page': pageNumber, 'limit': AppConstants.itemsPerPage},
    );

    return _handleResponse(response);
  }
  @override
  Future<List<BooksModel>> fetchTopRatedBooks({required int pageNumber}) async {
    final response = await apiService.get(
      endpoint: EndPoint.topRatedBooksEndpoint,
      query: {'page': pageNumber, 'limit': AppConstants.itemsPerPage},
    );

    return _handleResponse(response);
  }

  @override
  Future<List<BooksModel>> fetchNewsBooks({required int pageNumber}) async {
    final response = await apiService.get(
      endpoint: EndPoint.newsBooksEndpoint,
      query: {'page': pageNumber, 'limit': AppConstants.itemsPerPage},
    );
    return _handleResponse(response);
  }
   @override
  Future<List<BooksModel>> fetchQuickReadBooks({required int pageNumber})async {
 final response = await apiService.get(
      endpoint: EndPoint.quickReadEndpoint,
      query: {'page': pageNumber, 'limit': AppConstants.itemsPerPage},
    );
    return _handleResponse(response);
  }

  List<BooksModel> _handleResponse(dynamic data) {
    
    // التحقق من الحالة القادمة من السيرفر
    if (data['status'] == false) {
      throw ServerException(
        message: data['message'] ?? 'Unknown Error Occurred',
      );
    }

    // التحقق من وجود البيانات
    if (data['data'] != null && data['data'] is List) {
      // استخدام map بدلاً من for-loop لسرعة وكفاءة أعلى
      return List<BooksModel>.from(
        (data['data'] as List).map((e) => BooksModel.fromJson(e)),
      );
    }

    return [];
  }
  
 
}
