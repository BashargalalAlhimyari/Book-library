part of 'books_cubit.dart';

@immutable
sealed class BooksCubitDartState {}

final class BooksCubitDartInitial extends BooksCubitDartState {}

final class BooksCubitDartLoading extends BooksCubitDartState {}

final class BooksCubitPaginationLoading extends BooksCubitDartState {}

final class BooksCubitPaginationFailure extends BooksCubitDartState {
  BooksCubitPaginationFailure({required this.errMessage});
  final String errMessage;
}

final class BooksCubitDartFailure extends BooksCubitDartState {
  BooksCubitDartFailure({required this.errMessage});
  final String errMessage;
}

final class BooksCubitDartSuccess extends BooksCubitDartState {
  BooksCubitDartSuccess({required this.books});
  final List<BookEntity> books;
   

}
