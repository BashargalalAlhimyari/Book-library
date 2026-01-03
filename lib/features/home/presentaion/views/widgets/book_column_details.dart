
import 'package:clean_architecture/core/theme/styles.dart';

import 'package:flutter/material.dart';

class BookColumnDetailsWidget extends StatelessWidget {
  const BookColumnDetailsWidget({
    super.key, this.books, this.index,
  });
    final List? books;
    final int? index;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text("${books?[index!].title} $index",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle18,
            ),
          ),
          SizedBox(height: 3),
      
          Text("${books?[index!].authOrName}", style: Styles.textStyle14),
          SizedBox(height: 3),
          // Removed price and rating as they are not available in the new API
          if (books?[index!].categories != null && books![index!].categories!.isNotEmpty)
            Text(
              books![index!].categories!.first,
              style: Styles.textStyle14.copyWith(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}


