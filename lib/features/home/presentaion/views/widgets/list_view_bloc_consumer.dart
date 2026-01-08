import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/manager/featuredBooksCubit/books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/listview_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class listViewBlocConsumer extends StatefulWidget {
  const listViewBlocConsumer({super.key});

  @override
  State<listViewBlocConsumer> createState() => _listViewBlocBuilderState();
}

// ignore: camel_case_types
class _listViewBlocBuilderState extends State<listViewBlocConsumer> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubitDartCubit, BooksCubitDartState>(
      listener: (context, state) {
        if (state is BooksCubitDartSuccess) {
          for (var book in state.books) {
            if (!books.any(
              (existingBook) => existingBook.bookId == book.bookId,
            )) {
              books.add(book);
            }
          }
        }
        if (state is BooksCubitPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        if (state is BooksCubitDartSuccess ||
            state is BooksCubitPaginationLoading ||
            state is BooksCubitPaginationFailure) {
          return CostumListViewItems(books: books);
        } else if (state is BooksCubitDartFailure) {
          return Center(child: Icon(Icons.error, size: 50, color: Colors.red));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
