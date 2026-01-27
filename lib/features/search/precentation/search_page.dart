import 'package:clean_architecture/features/search/precentation/widgets/searchBooksConsumer.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return  const Scaffold(
   
      body:SearchBooksConsumer()
        
    );
  }

}