import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TopRatedBookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedConsumer extends StatelessWidget {
  const TopRatedConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedBooksCubit, TopRatedBooksState>(
      // 1. الليسنر فقط للأحداث الجانبية (مثل رسائل الخطأ)
      listener: (context, state) {
        if (state is TopRelatedPaginationFailure) {
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
        if (state is TopRelatedSuccess) {
          return Topratedbookcard(books: state.books);
        } else if (state is TopRelatedPaginationLoading) {
          return Topratedbookcard(books: state.books);
        } else if (state is TopRelatedPaginationFailure) {
          return Topratedbookcard(books: state.books);
        } else if (state is TopRelatedFailure) {
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
