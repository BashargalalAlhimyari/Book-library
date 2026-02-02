import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class HeadGestureService {
  static const MethodChannel _channel = MethodChannel('com.benamorn.liveness');

  bool _isBusy = false;
  DateTime _lastActionTime = DateTime.now();

  Future<void> processImage(
    CameraImage image,
    CameraDescription camera,
    Function onNext,
    Function onPrev,
  ) async {
    if (_isBusy) return;
    _isBusy = true;

    try {
      // 1. تجهيز البيانات (باستخدام Int32List لحل مشكلة الـ ArrayList)
      List<Uint8List> bytesList = [];
      
      // 👈 التعديل هنا: نحدد حجم المصفوفة مسبقاً ونستخدم نوع Int32List
      var strides = Int32List(image.planes.length * 2); 
      int index = 0;

      for (var plane in image.planes) {
        bytesList.add(plane.bytes);
        
        // تعبئة البيانات في المصفوفة الخام
        strides[index] = plane.bytesPerRow;
        index++;
        strides[index] = plane.bytesPerPixel ?? 1;
        index++;
      }

      // 2. استدعاء كود Kotlin
      final double? rotY = await _channel.invokeMethod<double?>("checkLiveness", {
        'platforms': bytesList,
        'height': image.height,
        'width': image.width,
        'strides': strides, // الآن يتم إرسالها كـ int[] وليس ArrayList
      });

      // 3. تحليل النتيجة
      if (rotY != null) {
        // فحص الوقت (ثانية واحدة بين كل حركة)
        if (DateTime.now().difference(_lastActionTime).inSeconds > 1) {
          
          // ⚠️ لقد رفعت الرقم إلى 30 لأن 5 حساس جداً ويسبب مشاكل
          if (rotY > 10) { 
            print("======================================");
            print("Turn LEFT << Action Triggered ($rotY)");
            onPrev();
            _lastActionTime = DateTime.now();
            
          } else if (rotY < -10) { 
                        print("======================================");

            print("Turn RIGHT >> Action Triggered ($rotY)");
            onNext();
            _lastActionTime = DateTime.now();
          }
        }
      }
    } on PlatformException catch (e) {
      print("Native Error: ${e.message}");
    } catch (e) {
      print("General Error: $e");
    } finally {
      _isBusy = false;
    }
  }

  void dispose() {}
}