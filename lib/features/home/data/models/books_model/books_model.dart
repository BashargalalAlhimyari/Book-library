import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

class BooksModel extends BookEntity {
  BooksModel({
    required int id,
    required super.title,
    required List<String> authors,
    String? description,
    String? image,
    List<String>? categories,
  }) : super(
          bookId: id.toString(),
          image: image ?? '',
          authOrName: authors.isNotEmpty ? authors.first : '',
          descrption: description,
          categories: categories ?? [],
        );

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    // Base URL for images
    const String uploadsBaseUrl = 'http://10.102.217.22:3000/uploads/';
    
    return BooksModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      authors: json['authors'] != null 
          ? (json['authors'] is String 
              ? (json['authors'] as String).split(',') 
              : List<String>.from(json['authors']))
          : [],
      description: json['description'],
      image: json['thumbnail'] != null 
          ? uploadsBaseUrl + json['thumbnail']
          : (json['image'] != null 
              ? uploadsBaseUrl + json['image']
              : null),
      categories: json['categories'] != null
          ? (json['categories'] is String
              ? (json['categories'] as String).split(',')
              : List<String>.from(json['categories']))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': int.tryParse(bookId),
        'title': title,
        'authors': authOrName != null ? [authOrName!] : [],
        'description': descrption,
        'image': image,
        'categories': categories,
      };
}
