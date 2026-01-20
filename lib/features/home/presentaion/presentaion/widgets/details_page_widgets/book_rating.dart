import 'package:clean_architecture/core/theme/styles.dart';
import 'package:flutter/material.dart';

class BookRatingWidget extends StatelessWidget {
  const BookRatingWidget({super.key, required this.rating});
  final num rating ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: Colors.amber, size: 20),
        Text("$rating", style: Styles.textStyle16),
        Text("(255)", style: Styles.textStyle14),
      ],
    );
  }
}