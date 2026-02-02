import 'package:clean_architecture/features/search/precentation/manager/search_books/search_books_cubit.dart';
import 'package:clean_architecture/features/search/precentation/widgets/searchBooksConsumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          // 2. إضافة Padding علوي لتبتعد عن حافة الشاشة
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            centerTitle: false, // لضمان بقاء حقل البحث في مكانه
            elevation: 0,
            leading: IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            title: Container(
              // 3. تغليف الـ TextField بـ Container للتحكم في المسافات الداخلية إذا أردت
              alignment: Alignment.center,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchBooksCubit>().search(value);
                },
                decoration: const InputDecoration(
                  prefix: SizedBox(width: 8), // مسافة بسيطة قبل النص
                  hintText: 'Search for books...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                  ), // موازنة النص داخل الحقل
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                cursorColor: Theme.of(context).primaryColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<SearchBooksCubit>().search('');
                },
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 8), // مسافة بسيطة في نهاية الـ AppBar
            ],
          ),
        ),
      ),
      body: const SearchBooksConsumer(),
    );
  }
}
