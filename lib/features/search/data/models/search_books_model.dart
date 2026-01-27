import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:hive/hive.dart';

// 1. إضافة اسم ملف الـ Generator
// 2. تحديد TypeId (اخترنا 2، تأكد أنه لا يتعارض مع ReadingProgressModel الذي أخذ 1)
@HiveType(typeId: 4)
class SearchBooksModel extends SearchBooksEntity {
  
  // 3. إعادة تعريف الحقول لإضافة HiveFields عليها
  @HiveField(0)
  @override
  final String bookId;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final List<String> authors;


  @HiveField(3)
  @override
  final List<String> images;

  @HiveField(4)
  @override
  final num price;

   SearchBooksModel({
    required this.bookId,
    required this.title,
    required this.authors,
    required this.images,
    required this.price,
  
  }) : super(
          bookId: bookId,
          title: title,
          authors: authors,
          images: images,
          price: price,
         
        );

     
        
  factory SearchBooksModel.fromJson(JsonMap json) {
   
 String getFullUrl(String? path) {
      if (path == null) return '';
      path = path.trim();
      if (path.isEmpty) return '';
      path = path.replaceAll('\\', '/');
      if (path.startsWith('http')) return path;
      return EndPoint.uploadsBaseUrl + path;
    }
    List<String> parsedImages = [];
    if (json['images'] != null) {
      if (json['images'] is String) {
        parsedImages = (json['images'] as String)
            .split(',')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
            .map((e) => getFullUrl(e))
            .toList();
      } else if (json['images'] is List) {
        parsedImages = (json['images'] as List)
            .map((e) => getFullUrl(e.toString()))
            .toList();
      }
    } else if (json['image'] != null) {
      parsedImages.add(getFullUrl(json['image'].toString()));
    }

    List<String> parsedAuthors = [];
    if (json['authors'] != null) {
      if (json['authors'] is String) {
        parsedAuthors = (json['authors'] as String).split(',');
      } else if (json['authors'] is List) {
        parsedAuthors = (json['authors'] as List)
            .map((e) => e.toString())
            .toList();
      }
    }


    num parsedPrice = 0;
    if (json['price'] != null) {
      if (json['price'] is String) {
        parsedPrice = num.tryParse(json['price']) ?? 0;
      } else {
        parsedPrice = json['price'];
      }
    }

    return SearchBooksModel(
      bookId: (json['id'] ?? 0).toString(),
      title: json['title'] ?? '',
      authors: parsedAuthors,
      images: parsedImages,
      price: parsedPrice,
    );
    
 
  }}


