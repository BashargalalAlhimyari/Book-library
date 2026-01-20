import 'package:flutter/material.dart';

class ResizableLayout extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;
  final double initialRatio; // النسبة الأولية (مثلا 0.4 لليسار)

  const ResizableLayout({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.initialRatio = 0.35, // القيمة الافتراضية
  });

  @override
  State<ResizableLayout> createState() => _ResizableLayoutState();
}

class _ResizableLayoutState extends State<ResizableLayout> {
  late double _leftRatio;

  @override
  void initState() {
    super.initState();
    _leftRatio = widget.initialRatio;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        // عرض المقبض (الفاصل)
        const double dividerWidth = 12.0; 

        return Row(
          children: [
            // 1️⃣ الجزء الأيسر (عرضه يعتمد على النسبة)
            SizedBox(
              width: (totalWidth * _leftRatio).clamp(
                100.0, // أقل عرض ممكن لليسار
                totalWidth - 100.0, // أقصى عرض ممكن
              ),
              child: widget.leftChild,
            ),

            // 2️⃣ المقبض (الفاصل القابل للسحب)
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              // عند السحب، نقوم بتحديث النسبة
              onHorizontalDragUpdate: (details) {
                setState(() {
                  // المعادلة: النسبة الجديدة = (العرض القديم + التغيير) / العرض الكلي
                  double newRatio = _leftRatio + (details.delta.dx / totalWidth);
                  
                  // نمنع النسبة من أن تكون صغيرة جداً أو كبيرة جداً (بين 0.2 و 0.8)
                  _leftRatio = newRatio.clamp(0.2, 0.8);
                });
              },
              // تغيير شكل الماوس عند المرور فوق الفاصل
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn, // شكل سهم التوسيع ↔️
                child: Container(
                  width: dividerWidth,
                  height: double.infinity,
                  color: Colors.transparent, // لون شفاف
                  child: Center(
                    child: Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4), // خط رمادي صغير في الوسط
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 3️⃣ الجزء الأيمن (يأخذ المساحة المتبقية)
            Expanded(
              child: widget.rightChild,
            ),
          ],
        );
      },
    );
  }
}