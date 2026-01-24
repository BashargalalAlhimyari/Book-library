import 'package:hive/hive.dart';


class BookEntity {
  final String bookId;

  final String title;

  final List<String> authors;

  final String description;

  final List<String> categories;

  final List<String> images; // صور المعرض


  final String subtitle; // العنوان الفرعي (مهم لكتب مثل Clean Code)

  final String coverUrl; // صورة الغلاف (أخف وأسرع من قائمة الصور)

  final num price; // نستخدم num ليقبل الفواصل (double) أو الأعداد الصحيحة (int)

  final num averageRating; // متوسط التقييم

  final int ratingCount; // عدد المقيمين

  final String fileUrl; // رابط تحميل الكتاب

  final int pageCount; // رابط تحميل الكتاب

 const BookEntity({
    required this.bookId,
    required this.title,
    required this.authors, // أصبح List<String>?
   required this.description,
    required this.categories,
    required this.images,
    required this.subtitle,
    required this.coverUrl,
    required this.price,
    required this.averageRating,
    required this.ratingCount,
    required this.fileUrl,
    required this.pageCount,
  });

  get id => null;
}