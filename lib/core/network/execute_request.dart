  import 'package:clean_architecture/core/errors/failure.dart';
import 'package:dio/dio.dart';
Future<dynamic> performRequest(Future<Response> requestFunc) async {
  try {
    final response = await requestFunc;
    return response.data;
  } on DioException catch (e) {
   
    throw ServerFailure.fromDioError(e); 
  } catch (e) {
    // هذا الجزء مهم جداً للإمساك بأي خطأ "غير متعلق بالـ API" 
    // مثل خطأ في تحويل البيانات (Parsing Error)
    throw ServerFailure(message: "حدث خطأ غير متوقع، حاول لاحقاً");
  }
}