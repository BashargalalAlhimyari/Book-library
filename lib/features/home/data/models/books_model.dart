import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/constants/endpoints.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:hive/hive.dart';

// 1. إضافة اسم ملف الـ Generator
part 'books_model.g.dart';

// 2. تحديد TypeId (اخترنا 2، تأكد أنه لا يتعارض مع ReadingProgressModel الذي أخذ 1)
@HiveType(typeId: 4)
class BooksModel extends BookEntity {
  
  // 3. إعادة تعريف الحقول لإضافة HiveFields عليها
  @HiveField(0)
  @override
  final String bookId;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String subtitle;

  @HiveField(3)
  @override
  final List<String> authors;

  @HiveField(4)
  @override
  final String description;

  @HiveField(5)
  @override
  final String coverUrl;

  @HiveField(6)
  @override
  final List<String> images;

  @HiveField(7)
  @override
  final List<String> categories;

  @HiveField(8)
  @override
  final num price;

  @HiveField(9)
  @override
  final num averageRating;

  @HiveField(10)
  @override
  final int ratingCount;

  @HiveField(11)
  @override
  final String fileUrl;

  @HiveField(12)
  @override
  final int pageCount;

  const BooksModel({
    required this.bookId,
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.description,
    required this.coverUrl,
    required this.images,
    required this.categories,
    required this.price,
    required this.averageRating,
    required this.ratingCount,
    required this.fileUrl,
    required this.pageCount,
  }) : super(
          bookId: bookId,
          title: title,
          subtitle: subtitle,
          authors: authors,
          description: description,
          coverUrl: coverUrl,
          images: images,
          categories: categories,
          price: price,
          averageRating: averageRating,
          ratingCount: ratingCount,
          fileUrl: fileUrl,
          pageCount: pageCount,
        );

  // ==========================================================
  // 🟢 الدالة الجديدة التي تحل مشكلة ReadingProgressModel
  // ==========================================================
  factory BooksModel.fromEntity(BookEntity entity) {
    return BooksModel(
      bookId: entity.bookId,
      title: entity.title,
      subtitle: entity.subtitle,
      authors: entity.authors,
      description: entity.description,
      coverUrl: entity.coverUrl,
      images: entity.images,
      categories: entity.categories,
      price: entity.price,
      averageRating: entity.averageRating,
      ratingCount: entity.ratingCount,
      fileUrl: entity.fileUrl,
      pageCount: entity.pageCount,
    );
  }

  // ==========================================================
  // 🟡 منطق الـ JSON الخاص بك (كما هو تماماً)
  // ==========================================================
  factory BooksModel.fromJson(JsonMap json) {
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

    List<String> parsedCategories = [];
    if (json['categories'] != null) {
      if (json['categories'] is String) {
        parsedCategories = (json['categories'] as String).split(',');
      } else if (json['categories'] is List) {
        parsedCategories = (json['categories'] as List)
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

    return BooksModel(
      bookId: (json['id'] ?? 0).toString(),
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      authors: parsedAuthors,
      categories: parsedCategories,
      images: parsedImages,
      coverUrl: json['coverUrl'] != null
          ? getFullUrl(json['coverUrl'].toString())
          : (parsedImages.isNotEmpty ? parsedImages.first : ''),
      fileUrl: getFullUrl(json['fileUrl']?.toString()),
      price: parsedPrice,
      averageRating: json['avgRating'] is num ? json['avgRating'] : 0,
      ratingCount: json['ratingCount'] is int ? json['ratingCount'] : 0,
      pageCount: json['pageCount'] is int ? json['pageCount'] : 0,
    );
  }

  Map<String, dynamic> toJson() => {
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