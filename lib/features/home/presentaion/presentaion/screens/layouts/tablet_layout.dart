import 'package:clean_architecture/core/widgets/shared/resizable_layout.dart.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/selected_book_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/details_page.dart';
import 'package:clean_architecture/core/widgets/shared/placeholderForNotSelectedItem.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/layouts/mobile_layout.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/screens/sideBar.dart';
// استيراد الملف الجديد الذي أنشأناه

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const Drawer(child: DesktopSideMenu()), // يفضل استخدام const
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.grey[200],

      body: BlocProvider.value(
        value:
            SelectedBookCubit(), // ⚠️ تنبيه: هنا يُفضل استخدام BlocProvider(create:..) إذا كان جديداً
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          // ✅ هنا التغيير الجوهري: استبدلنا Row بـ ResizableLayout
          child: ResizableLayout(
            initialRatio: 0.4, // القائمة تبدأ بـ 40% من الشاشة
            // 👉 الجزء الأيسر (القائمة)
            leftChild: _buildSection(context, child: const MobileLayout()),

            // 👉 الجزء الأيمن (التفاصيل)
            rightChild: _buildSection(
              context,
              child: BlocBuilder<SelectedBookCubit, BookEntity?>(
                builder: (context, book) {
                  if (book == null) {
                    return const PlaceholderForNotSelectedItem();
                  }
                  return DetailsPage(book: book);
                },
              ),
            ),
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
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
