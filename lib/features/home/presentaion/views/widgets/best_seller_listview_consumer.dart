import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/presentaion/manager/featuredNewsBooksCubit/cubit/news_books_cubit.dart';
import 'package:clean_architecture/features/home/presentaion/views/widgets/best_seller_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerListViewWidgets extends StatefulWidget {
  const BestSellerListViewWidgets({super.key});

  @override
  State<BestSellerListViewWidgets> createState() =>
      _BestSellerListViewWidgetsState();
}

class _BestSellerListViewWidgetsState extends State<BestSellerListViewWidgets> {
  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBooksCubit, NewsBooksState>(
      listener: (context, state) {
        if (state is NewsBooksSuccess) {
          for (var book in state.books) {
            if (!books.any((existingBook) => existingBook.bookId == book.bookId)) {
              books.add(book);
            }
          }
          print("✅ GET ${books.length} successful %%%%%%%%%%%%%%%%%%%");
        }

        if (state is NewsBooksCubitPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        if (state is NewsBooksSuccess ||
            state is NewsBooksCubitPaginationLoading ||
            state is NewsBooksCubitPaginationFailure) {
          return homeViewItem(books: books);
        } else if (state is NewsBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
      },
    );
  }
}
