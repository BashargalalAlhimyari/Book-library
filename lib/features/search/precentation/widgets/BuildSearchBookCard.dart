import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildSearchBookCard extends StatelessWidget {
   BuildSearchBookCard({super.key, required this.books});
  List<SearchBooksEntity> books;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: books.length, itemBuilder: (context, index) => Container(child: Text(books[index].title),),);
  }

}