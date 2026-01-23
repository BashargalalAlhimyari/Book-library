import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/quick_read_books_cubit/quick_read_books_cubit_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/QuickReadBookCard.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedBookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Quickreadbooksconsumer extends StatelessWidget {
  const Quickreadbooksconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuickReadBooksCubit, QuickReadBooksState>(
      // 1. الليسنر فقط للأحداث الجانبية (مثل رسائل الخطأ)
      listener: (context, state) {
        if (state is QuickReadPaginationFailure) {
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
        if (state is QuickReadSuccess) {
          return QuickReadCard(books: state.books);
        } else if (state is QuickReadPaginationLoading) {
          return QuickReadCard(books: state.books);
        } else if (state is QuickReadPaginationFailure) {
          return QuickReadCard(books: state.books);
        } else if (state is QuickReadFailure) {
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
