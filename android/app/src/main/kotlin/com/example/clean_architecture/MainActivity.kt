package com.example.clean_architecture 

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
// تم تصحيح mIkit إلى mlkit هنا وفي كل مكان 👇
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.face.FaceDetection
import com.google.mlkit.vision.face.FaceDetectorOptions
import com.google.mlkit.vision.face.Face // إضافة هذا الـ import
import android.graphics.ImageFormat
import android.graphics.Rect
import java.nio.ByteBuffer

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.benamorn.liveness"

    // إعدادات كاشف الوجه (سريع)
    private val realTimeOpts = FaceDetectorOptions.Builder()
        .setPerformanceMode(FaceDetectorOptions.PERFORMANCE_MODE_FAST)
        .setContourMode(FaceDetectorOptions.CONTOUR_MODE_NONE)
        .setLandmarkMode(FaceDetectorOptions.LANDMARK_MODE_NONE)
        .setClassificationMode(FaceDetectorOptions.CLASSIFICATION_MODE_NONE)
        .build()

    private val detector = FaceDetection.getClient(realTimeOpts)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "checkLiveness") {
                try {
                    val planes = call.argument<List<ByteArray>>("platforms")
                    val width = call.argument<Int>("width")
                    val height = call.argument<Int>("height")
                    
                    // ✅✅✅ التعديل الجذري هنا:
                    // نستقبلها مباشرة كـ IntArray لأن فلاتر يرسلها الآن كـ Int32List
                    val strides = call.argument<IntArray>("strides")

                    if (planes != null && width != null && height != null && strides != null) {
                        
                        val nv21Data = YuvConverter.yuvToNV21(planes, strides, width, height)

                        val inputImage = InputImage.fromByteArray(
                            nv21Data,
                            width,
                            height,
                            0, 
                            InputImage.IMAGE_FORMAT_NV21
                        )

                        detector.process(inputImage)
                            .addOnSuccessListener { faces ->
                                if (faces.isNotEmpty()) {
                                    val face = faces[0]
                                    result.success(face.headEulerAngleY)
                                } else {
                                    result.success(null) 
                                }
                            }
                            .addOnFailureListener { e ->
                                result.error("DETECTION_ERROR", e.message, null)
                            }
                    } else {
                        result.error("INVALID_ARGS", "Missing image data or strides", null)
                    }
                } catch (e: Exception) {
                    android.util.Log.e("FaceDetection", "Error: ${e.message}")
                    result.error("ERROR", e.message, null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}

// ================================================================
// كود التحويل (YuvConverter)
// ================================================================
object YuvConverter {
    fun yuvToNV21(planes: List<ByteArray>, strides: IntArray, width: Int, height: Int): ByteArray {
        val crop = Rect(0, 0, width, height)
        val format = ImageFormat.YUV_420_888
        val data = ByteArray(width * height * ImageFormat.getBitsPerPixel(format) / 8)
        val rowData = ByteArray(strides[0])
        var channelOffset = 0
        var outputStride = 1
        
        for (i in planes.indices) {
            when (i) {
                0 -> {
                    channelOffset = 0
                    outputStride = 1
                }
                1 -> {
                    channelOffset = width * height + 1
                    outputStride = 2
                }
                2 -> {
                    channelOffset = width * height
                    outputStride = 2
                }
            }

            val buffer = ByteBuffer.wrap(planes[i])
            val rowStride: Int
            val pixelStride: Int
            if (i == 0) {
                rowStride = strides[i]
                pixelStride = strides[i + 1]
            } else {
                rowStride = strides[i * 2]
                pixelStride = strides[i * 2 + 1]
            }
            
            val shift = if (i == 0) 0 else 1
            val w = width shr shift
            val h = height shr shift
            buffer.position(rowStride * (crop.top shr shift) + pixelStride * (crop.left shr shift))
            
            for (row in 0 until h) {
                val length: Int
                if (pixelStride == 1 && outputStride == 1) {
                    length = w
                    buffer.get(data, channelOffset, length)
                    channelOffset += length
                } else {
                    length = (w - 1) * pixelStride + 1
                    buffer.get(rowData, 0, length)
                    for (col in 0 until w) {
                        data[channelOffset] = rowData[col * pixelStride]
                        channelOffset += outputStride
                    }
                }
                if (row < h - 1) {
                    buffer.position(buffer.position() + rowStride - length)
                }
            }
        }
        return data
    }
}