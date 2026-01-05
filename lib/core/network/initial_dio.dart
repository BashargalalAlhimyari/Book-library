import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/core/network/check_internet.dart';
import 'package:clean_architecture/core/utils/token_storage.dart';
import 'package:dio/dio.dart';

 String _baseUrl = EndPoint.baseUrl;

void initialiseDio(Dio _dio) {
  _dio.options
    ..baseUrl = _baseUrl
    ..connectTimeout = const Duration(seconds: 10)
    ..receiveTimeout = const Duration(seconds: 10)
    ..headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

  // إضافة Interceptor لمعالجة المهام المتكررة (فحص النت، التوكن)
  _dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // A. فحص الإنترنت مركزياً قبل خروج أي طلب
        if (await hasNoInternet()) {
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'لا يوجد اتصال بالإنترنت', // رسالة واضحة
              type: DioExceptionType.connectionError,
            ),
          );
        }

        // B. حقن التوكن تلقائياً إذا وجد
        final token = TokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      // يمكنك إضافة onError هنا لمعالجة حالات مثل Token Expired (401)
    ),
  );
}
