import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

class BooksModel extends BookEntity {
  BooksModel({
    required int id,
    required super.title,
    required List<String> authors,
    String? description,
    List<String>? images,
    List<String>? categories,
  }) : super(
         bookId: id.toString(),
         images: images ?? [],
         authOrName: authors.isNotEmpty ? authors.first : '',
         descrption: description,
         categories: categories ?? [],
       );

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];
    if (json['images'] != null) {
      if (json['images'] is String) {
        parsedImages = (json['images'] as String)
            .split(',')
            .map((e) => EndPoint.uploadsBaseUrl + e.trim())
            .toList();
      } else if (json['images'] is List) {
        parsedImages = (json['images'] as List)
            .map((e) => EndPoint.uploadsBaseUrl + e.toString())
            .toList();
      }
    } else if (json['image'] != null) {
      parsedImages.add(EndPoint.uploadsBaseUrl + json['image']);
    } else if (json['thumbnail'] != null) {
      parsedImages.add(EndPoint.uploadsBaseUrl + json['thumbnail']);
    }

    return BooksModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      authors:
          json['authors'] != null
              ? (json['authors'] is String
                  ? (json['authors'] as String).split(',')
                  : List<String>.from(json['authors']))
              : [],
      description: json['description'],
      images: parsedImages,
      categories:
          json['categories'] != null
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
    'images': images,
    'categories': categories,
  };
}
