import 'package:clean_architecture/features/search/precentation/manager/search_books/search_books_cubit.dart';
import 'package:clean_architecture/features/search/precentation/widgets/searchBooksConsumer.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final bool isDark;
  final SearchBooksCubit searchCubit; // 1. نحتفظ بنسخة من الكيوبت

  // نستقبل الكيوبت في البناء لضمان الوصول إليه
  CustomSearchDelegate({required this.isDark, required this.searchCubit});



  // ===============================
  // 2. زر المسح (X)
  // ===============================
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // ===============================
  // 3. زر العودة (Back)
  // ===============================
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // ===============================
  // 4. عرض النتائج النهائية (عند ضغط Enter)
  // ===============================
  @override
  Widget buildResults(BuildContext context) {
    // نقوم باستدعاء دالة البحث في الكيوبت
    searchCubit.fetchSearchBooks();

    return const SearchBooksConsumer();
  }

  // ===============================
  // 5. الاقتراحات أثناء الكتابة
  // ===============================
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('اكتب شيئاً للبحث'));
    }

    // ملاحظة: يفضل استخدام Debounce هنا لتقليل طلبات السيرفر، لكن هذا الكود سيعمل
    searchCubit.fetchSearchBooks();

    return const SearchBooksConsumer();
  }
}
