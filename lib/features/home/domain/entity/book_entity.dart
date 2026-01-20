import 'package:hive/hive.dart';

part 'book_entity.g.dart';

@HiveType(typeId: 0)
class BookEntity {
  @HiveField(0)
  final String bookId;

  @HiveField(1) 
  final String title;

  @HiveField(2) // 🔄 تم التعديل: أصبح قائمة بدلاً من نص واحد
  final List<String>? authors;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final List<String>? categories;

  @HiveField(5)
  final List<String>? images; // صور المعرض

  // --- 🆕 حقول جديدة تمت إضافتها بناءً على رد السيرفر الجديد ---

  @HiveField(6)
  final String? subtitle; // العنوان الفرعي (مهم لكتب مثل Clean Code)

  @HiveField(7)
  final String? coverUrl; // صورة الغلاف (أخف وأسرع من قائمة الصور)

  @HiveField(8)
  final num? price; // نستخدم num ليقبل الفواصل (double) أو الأعداد الصحيحة (int)

  @HiveField(9)
  final num? averageRating; // متوسط التقييم

  @HiveField(10)
  final int? ratingCount; // عدد المقيمين

  @HiveField(11)
  final String? fileUrl; // رابط تحميل الكتاب

 const BookEntity({
    required this.bookId,
    required this.title,
    required this.authors, // أصبح List<String>?
    this.description,
    this.categories,
    this.images,
    this.subtitle,
    this.coverUrl,
    this.price,
    this.averageRating,
    this.ratingCount,
    this.fileUrl,
  });
}