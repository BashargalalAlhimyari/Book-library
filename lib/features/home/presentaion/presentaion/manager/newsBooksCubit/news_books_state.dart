part of 'news_books_cubit.dart';

@immutable
sealed class NewsBooksState {}

final class NewsBooksInitial extends NewsBooksState {}

final class NewsBooksLoading extends NewsBooksState {}

final class NewsBooksPaginationLoading extends NewsBooksState {
  NewsBooksPaginationLoading({required this.books});
  final List<BookEntity> books;
}

final class NewsBooksPaginationFailure extends NewsBooksState {
  NewsBooksPaginationFailure( {required this.errMessage, required this.books });
    final List<BookEntity> books;

  final String errMessage;
}

final class NewsBooksFailure extends NewsBooksState {
  NewsBooksFailure({required this.errMessage});
  final String errMessage;
}

final class NewsBooksSuccess extends NewsBooksState {
  NewsBooksSuccess({required this.books});
  final List<BookEntity> books;
}
