import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/network/dio_error_handler.dart';
import 'package:dio/dio.dart';
Future<dynamic> performRequest(Future<Response> requestFunc) async {
  try {
    final response = await requestFunc;
    return response.data;
  } on DioException catch (e) {
   
    throw DioErrorHandler.handle(e); 
  } catch (e) {
    // هذا الجزء مهم جداً للإمساك بأي خطأ "غير متعلق بالـ API" 
    // مثل خطأ في تحويل البيانات (Parsing Error)
    throw ServerFailure( "حدث خطأ غير متوقع، حاول لاحقاً");
  }
}

/*
 كيف تعمل Dio افتراضياً؟
مكتبة Dio لديها إعداد افتراضي يسمى validateStatus.
الشرط الافتراضي هو: أي كود حالة (Status Code) بين 200 و 299 يعتبر نجاحاً.
إذا كان الكود 200: الدالة تكمل تنفيذ السطر التالي return response.data;.
إذا كان الكود غير ذلك (مثلاً 400، 404، 500): تقوم Dio برمي استثناء (Exception) من نوع DioException 
فوراً، مما ينقل التنفيذ مباشرة إلى بلوك on DioException catch (e).
 */