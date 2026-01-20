
part of 'quick_read_books_cubit_cubit.dart';

sealed class QuickReadBooksState {}
//sealed class: يسمح بالوراثة داخل نفس الملف فقط ويمنعها خارجه.

final class QuickReadInitial extends  QuickReadBooksState{}
//final class: يمنع أي كلاس آخر من الوراثة منه (Extending) تماماً، حتى داخل نفس الملف.

final class QuickReadLoading extends QuickReadBooksState {}

final class QuickReadPaginationLoading extends QuickReadBooksState {
  QuickReadPaginationLoading({required this.books});
  final List<BookEntity> books;
}

final class QuickReadPaginationFailure extends QuickReadBooksState {
  QuickReadPaginationFailure({required this.errMessage, required this.books});
  final String errMessage;
  final List<BookEntity> books;
}

final class QuickReadFailure extends QuickReadBooksState {
  QuickReadFailure({required this.errMessage});
  final String errMessage;
}

final class QuickReadSuccess extends QuickReadBooksState {
  QuickReadSuccess({required this.books});
  final List<BookEntity> books;
   

}
