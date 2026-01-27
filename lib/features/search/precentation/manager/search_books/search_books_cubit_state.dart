part of 'search_books_cubit.dart';

sealed class SearchBooksCubitState {
  const SearchBooksCubitState();
}

final class SearchBooksInitial extends SearchBooksCubitState {}

final class SearchBooksLoading extends SearchBooksCubitState {}

final class SearchBooksPaginationLoading extends SearchBooksCubitState {
  SearchBooksPaginationLoading({required this.books});
  final List<SearchBooksEntity> books;
}

final class SearchBooksPaginationFailure extends SearchBooksCubitState {
  SearchBooksPaginationFailure({required this.errMessage, required this.books});
  final List<SearchBooksEntity> books;

  final String errMessage;
}

final class SearchBooksFailure extends SearchBooksCubitState {
  SearchBooksFailure({required this.errMessage});
  final String errMessage;
}

final class SearchBooksSuccess extends SearchBooksCubitState {
  SearchBooksSuccess({required this.books});
  final List<SearchBooksEntity> books;
}
