import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:equatable/equatable.dart';

class ReadingProgressEntity extends Equatable {
  final int userId;
  final int bookId;
  final int currentPage;
  final int totalPages;
  final bool isCompleted;
  final DateTime? lastReadAt;
  final BookEntity? book;

  const ReadingProgressEntity({
    required this.userId,
    required this.bookId,
    required this.currentPage,
    required this.totalPages,
    required this.isCompleted,
    this.lastReadAt,
    this.book,
  });

  @override
  List<Object?> get props => [userId, bookId, currentPage, totalPages, isCompleted, lastReadAt, book];
}
