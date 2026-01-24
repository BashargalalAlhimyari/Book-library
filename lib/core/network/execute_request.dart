import 'package:clean_architecture/core/errors/exception.dart'; // تأكد من استيراد كلاس الاكسبشن
import 'package:clean_architecture/core/network/dio_error_handler.dart';
import 'package:clean_architecture/core/routes/navigatorKey.dart';
import 'package:clean_architecture/core/routes/paths_routes.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> performRequest(Future<Response> requestFunc) async {
  try {

    final response = await requestFunc;
print(response.data['message']);
    // التحقق من نجاح الرد
    if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300) {
       return response.data;
    }
   
     else {

       throw ServerException(message: "استجابة غير صحيحة: ${response.statusCode}");
    }

  } on DioException catch (e) {

    // 1. نستخرج رسالة الخطأ من الهاندلر
    final failure = DioErrorHandler.handle(e);
    
    // 2. 🛑 التعديل الأهم: نرميها كـ Exception وليس Failure
    throw ServerException(message: failure.message); 

  } catch (e) {

    // التقاط أخطاء الكود (مثل null check operator)
    throw ServerException(message: e.toString());
  }
}