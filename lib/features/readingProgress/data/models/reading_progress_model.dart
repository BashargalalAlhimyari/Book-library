import 'package:clean_architecture/features/home/data/models/books_model.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';
import 'package:hive/hive.dart';

part 'reading_progress_model.g.dart';

@HiveType(typeId: 5)
class ReadingProgressModel extends ReadingProgressEntity {
  
  @HiveField(0)
  @override
  final int userId;

  @HiveField(1)
  @override
  final int bookId;

  @HiveField(2)
  @override
  final int currentPage;

  @HiveField(3)
  @override
  final int totalPages;

  @HiveField(4)
  @override
  final bool isCompleted;

  @HiveField(5)
  @override
  final DateTime? lastReadAt;

  @HiveField(6)
  @override
  final BooksModel? book; 

  const ReadingProgressModel({
    required this.userId,
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    required this.isCompleted,
    this.lastReadAt,
    this.book,
  }) : super(
          userId: userId,
          bookId: bookId,
          currentPage: currentPage,
          totalPages: totalPages,
          isCompleted: isCompleted,
          lastReadAt: lastReadAt,
          book: book,
        );

  factory ReadingProgressModel.fromJson(Map<String, dynamic> json) {
    return ReadingProgressModel(
      userId: json['userId'] is int ? json['userId'] : int.tryParse(json['userId'].toString()) ?? 0,
      bookId: json['bookId'] is int ? json['bookId'] : int.tryParse(json['bookId'].toString()) ?? 0,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
      lastReadAt: json['lastReadAt'] != null ? DateTime.parse(json['lastReadAt']) : null,
      book: json['Book'] != null ? BooksModel.fromJson(json['Book']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'bookId': bookId,
      'currentPage': currentPage,
      'totalPages': totalPages,
      'isCompleted': isCompleted,
      'lastReadAt': lastReadAt?.toIso8601String(),
      'Book': book?.toJson(),
    };
  }

  // ✅ التصحيح هنا: نستخدم BooksModel.fromEntity لإنشاء موديل جديد
  factory ReadingProgressModel.fromEntity(ReadingProgressEntity entity) {
    return ReadingProgressModel(
      userId: entity.userId,
      bookId: entity.bookId,
      currentPage: entity.currentPage,
      totalPages: entity.totalPages,
      isCompleted: entity.isCompleted,
      lastReadAt: entity.lastReadAt,
      
      // ✅ التعديل: إذا وجد الكتاب، نقوم بتحويله باستخدام الدالة التي أنشأناها في الخطوة 1
      book: entity.book != null ? BooksModel.fromEntity(entity.book!) : null,
    );
  }
}