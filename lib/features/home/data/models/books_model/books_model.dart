import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

class BooksModel extends BookEntity {
  const BooksModel({
    required super.bookId,
    required super.title,
    required super.subtitle,
    required super.authors,
    required super.description,
    required super.coverUrl,
    required super.images,
    required super.categories,
    required super.price,
    required super.averageRating,
    required super.ratingCount,
    required super.fileUrl,
    required super.pageCount,
  });

  factory BooksModel.fromJson(JsonMap json) {
    // 1. دالة مساعدة لمعالجة الروابط
    String getFullUrl(String? path) {
      if (path == null) return ''; // حماية من null
      path = path.trim();
      if (path.isEmpty) return '';
      // Normalize path separators
      path = path.replaceAll('\\', '/');
      if (path.startsWith('http')) return path;
      return EndPoint.uploadsBaseUrl + path;
    }

    // 2. معالجة الصور
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

    // 3. معالجة المؤلفين
    List<String> parsedAuthors = [];
    if (json['authors'] != null) {
      if (json['authors'] is String) {
        parsedAuthors = (json['authors'] as String).split(',');
      } else if (json['authors'] is List) {
        parsedAuthors = (json['authors'] as List)
            .map((e) => e.toString()) // toString لمنع الكراش
            .toList();
      }
    }

    // 4. معالجة التصنيفات
    List<String> parsedCategories = [];
    if (json['categories'] != null) {
      if (json['categories'] is String) {
        parsedCategories = (json['categories'] as String).split(',');
      } else if (json['categories'] is List) {
        parsedCategories = (json['categories'] as List)
            .map((e) => e.toString()) // toString أأمن من List.from
            .toList();
      }
    }

    // 5. معالجة السعر
    num parsedPrice = 0;
    if (json['price'] != null) {
      if (json['price'] is String) {
        parsedPrice = num.tryParse(json['price']) ?? 0;
      } else {
        parsedPrice = json['price'];
      }
    }

    return BooksModel(
      // ✅ التصحيح المهم هنا: تحويل الرقم إلى نص
      bookId: (json['id'] ?? 0).toString(), 
      
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      authors: parsedAuthors,
      categories: parsedCategories,
      images: parsedImages,

      // استخدام toString لحماية coverUrl
      coverUrl: json['coverUrl'] != null
          ? getFullUrl(json['coverUrl'].toString())
          : (parsedImages.isNotEmpty ? parsedImages.first : ''),

      fileUrl: getFullUrl(json['fileUrl']?.toString()),

      price: parsedPrice,
      // التأكد أن هذه القيم num/int
      averageRating: json['avgRating'] is num ? json['avgRating'] : 0, 
      ratingCount: json['ratingCount'] is int ? json['ratingCount'] : 0,
      pageCount: json['pageCount'] is int ? json['pageCount'] : 0,
    );
  }

  Map<String, dynamic> toJson() => {
        // تحويل النص لرقم عند الإرسال (اختياري حسب الباك إند)
        'id': int.tryParse(bookId) ?? 0, 
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'authors': authors,
        'categories': categories,
        'images': images,
        'coverUrl': coverUrl,
        'price': price,
        'fileUrl': fileUrl,
        'avgRating': averageRating,
        'ratingCount': ratingCount,
        'pageCount': pageCount,
      };
}