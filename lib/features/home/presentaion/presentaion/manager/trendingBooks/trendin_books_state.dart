

part of 'trendin_books_cubit.dart';

@immutable
sealed class TrendingBooksState {}

final class TrendingBooksInitial extends TrendingBooksState {}

final class TrendingBooksLoading extends TrendingBooksState {}


final class TrendingBooksPaginationLoading extends TrendingBooksState {
  TrendingBooksPaginationLoading({required this.books});
  final List<BookEntity> books;
}

final class TrendingBooksPaginationFailure extends TrendingBooksState {
  TrendingBooksPaginationFailure({required this.errMessage, required this.books});
  final String errMessage;
  final List<BookEntity> books;
}

final class TrendingBooksFailure extends TrendingBooksState {
  TrendingBooksFailure({required this.errMessage});
  final String errMessage;
}

final class TrendingBooksSuccess extends TrendingBooksState {
  TrendingBooksSuccess({required this.books});
  final List<BookEntity> books;
}
