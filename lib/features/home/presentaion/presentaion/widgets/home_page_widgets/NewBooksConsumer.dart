import 'package:clean_architecture/features/home/presentaion/presentaion/manager/newsBooksCubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/NewBookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newbooksconsumer extends StatelessWidget {
  const Newbooksconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBooksCubit, NewsBooksState>(
      // 1. الليسنر فقط للأحداث الجانبية (مثل رسائل الخطأ)
      listener: (context, state) {
        if (state is NewsBooksPaginationFailure) {
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
        if (state is NewsBooksSuccess) {
          return NewBookPaginatedGrid(books: state.books);
        } else if (state is NewsBooksPaginationLoading) {
          return NewBookPaginatedGrid(books: state.books);
        } else if (state is NewsBooksPaginationFailure) {
          return NewBookPaginatedGrid(books: state.books);
        } else if (state is NewsBooksFailure) {
          return const Center(
            child: Icon(Icons.error, size: 50, color: Colors.yellow),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
      },
    );
  }
}
