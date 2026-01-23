import 'dart:io';
import 'package:clean_architecture/core/di/service_locator.dart';
import 'package:clean_architecture/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PdfService {
  final Dio _dio = Dio();

  Future<File?> downloadFile(String url, String fileName) async {
    try {
   
      String finalUrl = url;

      finalUrl = finalUrl.replaceAll('\\', '/');

      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$fileName');

      // حذف الملف القديم إذا كان تالفاً (حجمه 0)
      if (await file.exists()) {
        if (await file.length() == 0) {
          await file.delete();
        } else {
          return file; // الملف موجود وسليم
        }
      }

      final response =await getIt<ApiService>().download(
        finalUrl: finalUrl,
        path: file.path,
      );

      if (response.statusCode == 200) {
        return file;
      } else {
        print("❌ فشل التحميل كود: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ خطأ أثناء التحميل: $e");
      return null;
    }
  }
}
