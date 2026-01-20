import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/newsBooksCubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/trendingBooks/trendin_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/widgets/home_page_widgets/TrendingBookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Trendingbooksconsumer extends StatefulWidget {
  const Trendingbooksconsumer({super.key});

  @override
  State<Trendingbooksconsumer> createState() => _TrendingbooksconsumerState();
}

class _TrendingbooksconsumerState extends State<Trendingbooksconsumer> {
  List<BookEntity> books = [];

  @override
  void initState() {
    super.initState();
    final state = context.read<TrendingBooksCubit>().state;
    if (state is TrendingBooksSuccess) {
      books = List.from(state.books);
    } else if (state is TrendingBooksPaginationLoading) {
      books = List.from(state.books);
    } else if (state is TrendingBooksPaginationFailure) {
      books = List.from(state.books);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingBooksCubit, TrendingBooksState>(
      listener: (context, state) {
        if (state is TrendingBooksPaginationFailure) {
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
        if (state is TrendingBooksSuccess) {
          return Trendingbookcard(books: state.books);
        } else if (state is TrendingBooksPaginationFailure) {
          return Trendingbookcard(books: state.books);
        } else if (state is TrendingBooksPaginationLoading) {
          return Trendingbookcard(books: state.books);
        } else if (state is TrendingBooksFailure) {
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
