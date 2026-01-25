import 'package:clean_architecture/core/constants/app_constants.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/navigate_cubit.dart'; // تأكد من المسار
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/details_page.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/sideBar.dart';
import 'package:clean_architecture/core/widgets/shared/placeholderForNotSelectedItem.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/layouts/mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.grey[200],
      body: BlocProvider.value(
        value: SelectedBookCubit(), // كيوبت التفاصيل
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
            
              _buildSection(
                context,
                // نستخدم عرض ثابت للقائمة الجانبية وليس Expanded
                child: const SizedBox(
                  width: 270, 
                  child: DesktopSideMenu(),
                ),
              ),
              
              const SizedBox(width: 12),

              // ====================================================
              // 2️⃣ منطقة المحتوى المتغير (Dynamic Content)
              // ====================================================
              Expanded(
                flex: 4, // حصة كبيرة للمحتوى
                child: _buildSection(
                  context,
                  // هنا نستمع لتغيير الصفحة من السايد بار
                  child: BlocBuilder<NavigateCubit, int>(
                    builder: (context, state) {
                      // بناءً على الاندكس المختار، نعرض الصفحة المناسبة
                      if (state == 0) {
                        return const MobileLayout(); // صفحة الكتب
                      } else if (state == 1) {
                        return const Center(child: Text("صفحة البحث")); // مثال
                      } else if (state == 2) {
                        return const Center(child: Text("مكتبتي")); // مثال
                      } else {
                        return const Center(child: Text("الإعدادات"));
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // ====================================================
              // 3️⃣ منطقة التفاصيل (Details Panel)
              // ====================================================
              // هذه المنطقة تظهر فقط إذا كنا في الصفحة الرئيسية (index == 0)
              // أو يمكن تركها فارغة في الصفحات الأخرى
              BlocBuilder<NavigateCubit, int>(
                builder: (context, state) {
                  // إذا لم نكن في الصفحة الرئيسية، نخفي لوحة التفاصيل
                  if (state != 0) {
                    return const SizedBox(); 
                  }
                  
                  return Expanded(
                    flex: 3, // حصة التفاصيل
                    child: _buildSection(
                      context,
                      child: BlocBuilder<SelectedBookCubit, BookEntity?>(
                        builder: (context, book) {
                          if (book == null) {
                            // [Image of empty state illustration]
                            return const PlaceholderForNotSelectedItem();
                          }
                          return DetailsPage(book: book);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        // إضافة ظل خفيف لجمالية الديسكتوب
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}