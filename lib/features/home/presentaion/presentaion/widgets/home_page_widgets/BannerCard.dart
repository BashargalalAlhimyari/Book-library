import 'package:clean_architecture/core/theme/colors.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/CardDotedCubit/card_doted_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bannercard extends StatelessWidget {
  const Bannercard({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. تقييد العرض: في الديسكتوب، لا نريد الكارد أن يأخذ عرض الشاشة بالكامل
    // نضعه في Center و ConstrainedBox
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 600, // أقصى عرض للكارد (ممتاز للتابلت والويب)
      ),
      child: SizedBox(
        // 2. الارتفاع: نثبته بقيمة منطقية بدلاً من نسبة الشاشة
        // لأن الكارد لا يجب أن يكبر جداً في الشاشات العملاقة
        height: 200,
        child: Column(
          children: [
            Expanded(
              // الكارد يأخذ المساحة المتاحة له
              child: PageView.builder(
                onPageChanged: (index) {
                  context.read<CardDotedCubit>().changeCardDoted(index);
                },
                itemCount: 2,
                itemBuilder:
                    (context, index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.indigo.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // 3. الصورة المتجاوبة (أهم نقطة) 🖼️
                          // نستخدم AspectRatio بدلاً من width/height ثابت
                          AspectRatio(
                            aspectRatio: 2 / 3, // نسبة غلاف الكتاب القياسية
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/images/test_image.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          // 4. النصوص وتفاصيل التقدم
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center, // توسيط عمودي
                              children: [
                                const Text(
                                  "استكمل القراءة",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // عنوان الكتاب (يستخدم سطرين كحد أقصى لتجنب المشاكل)
                                const Text(
                                  "أولاد حارتنا",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20, // كبرنا الخط قليلاً
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "نجيب محفوظ",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),

                                const Spacer(), // يدفع العناصر للأسفل
                                // شريط التقدم
                                LinearProgressIndicator(
                                  value: 0.8,
                                  backgroundColor: Colors.white24,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  minHeight: 6,
                                ),
                                const SizedBox(height: 8),

                                // تفاصيل الصفحات (استخدام FittedBox للحماية)
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "30% مكتمل",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    // في الشاشات الصغيرة جداً، هذا النص قد ينكسر
                                    // Flexible يحميه
                                    Flexible(
                                      child: Text(
                                        "120 من 350 صفحة",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),

            // 5. النقاط (Dotted Widget) - قمنا بتحسينها سابقاً
            const SizedBox(height: 10),
            BlocBuilder<CardDotedCubit, CardDotedState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: state.selectedIndex == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: AppColors.indigo,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    );
                  }),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
