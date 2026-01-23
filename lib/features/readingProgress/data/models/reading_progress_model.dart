import 'package:clean_architecture/features/home/data/models/books_model/books_model.dart';
import 'package:clean_architecture/features/readingProgress/domain/entity/reading_progress_entity.dart';

class ReadingProgressModel extends ReadingProgressEntity {
  const ReadingProgressModel({
    required super.userId,
    required super.bookId,
    required super.currentPage,
    required super.totalPages,
    required super.isCompleted,
    super.lastReadAt,
    super.book,
  });

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
      'book': book != null ? (book as BooksModel).toJson() : null,
    };
  }

  factory ReadingProgressModel.fromEntity(ReadingProgressEntity entity) {
    return ReadingProgressModel(
      userId: entity.userId,
      bookId: entity.bookId,
      currentPage: entity.currentPage,
      totalPages: entity.totalPages,
      isCompleted: entity.isCompleted,
      lastReadAt: entity.lastReadAt,
      book: entity.book,
    );
  }
}
