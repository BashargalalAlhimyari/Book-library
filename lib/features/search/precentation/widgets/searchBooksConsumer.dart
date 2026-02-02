
import 'package:clean_architecture/features/search/precentation/manager/search_books/search_books_cubit.dart';
import 'package:clean_architecture/features/search/precentation/widgets/BuildSearchBookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBooksConsumer extends StatelessWidget {
  const SearchBooksConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBooksCubit, SearchBooksCubitState>(
      // 1. الليسنر فقط للأحداث الجانبية (مثل رسائل الخطأ)
      listener: (context, state) {
        if (state is SearchBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SearchBooksSuccess) {
          return BuildSearchBookCard(books: state.books);
        } else if (state is SearchBooksPaginationLoading) {
          return BuildSearchBookCard(books: state.books);
        } else if (state is SearchBooksPaginationFailure) {
          return BuildSearchBookCard(books: state.books);
        } else if (state is SearchBooksFailure) {
          return const Center(
            child: Icon(Icons.error, size: 50, color: Colors.yellow),
          );
        } else if (state is SearchBooksInitial) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text("Search for books...", style: TextStyle(color: Colors.grey, fontSize: 18)),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
