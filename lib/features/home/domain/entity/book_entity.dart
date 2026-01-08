import 'package:hive/hive.dart';

part  'book_entity.g.dart';
@HiveType(typeId: 0)
class BookEntity {
  // الانتيتي تعبر عن البيانات التي تنعرض في الواجهة
  @HiveField(0)
  final String bookId;
  @HiveField(6)
  final List<String>? images;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? authOrName;
  @HiveField(4)
  final String? descrption;
  @HiveField(5)
  final List<String>? categories;

  BookEntity({
    required this.descrption,
    required this.bookId,
    required this.images,
    required this.title,
    required this.authOrName,
    required this.categories,
  });
}
