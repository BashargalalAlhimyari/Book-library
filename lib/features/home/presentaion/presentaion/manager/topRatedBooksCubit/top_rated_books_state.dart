part of 'top_rated_books_cubit.dart';
// part of: تشير إلى أن هذا الملف هو جزء من ملف آخر محدد (في هذه الحالة 'books_cubit.dart').
//@immutable: تشير إلى أن جميع خصائص الكلاس غير قابلة للتغيير بعد إنشائه.
sealed class TopRatedBooksState {}
//sealed class: يسمح بالوراثة داخل نفس الملف فقط ويمنعها خارجه.

final class TopRelatedInitial extends TopRatedBooksState {}
//final class: يمنع أي كلاس آخر من الوراثة منه (Extending) تماماً، حتى داخل نفس الملف.

final class TopRelatedLoading extends TopRatedBooksState {}

final class TopRelatedPaginationLoading extends TopRatedBooksState {
  TopRelatedPaginationLoading({required this.books});
  final List<BookEntity> books;
}

final class TopRelatedPaginationFailure extends TopRatedBooksState {
  TopRelatedPaginationFailure({required this.errMessage, required this.books});
  final String errMessage;
  final List<BookEntity> books;
}

final class TopRelatedFailure extends TopRatedBooksState {
  TopRelatedFailure({required this.errMessage});
  final String errMessage;
}

final class TopRelatedSuccess extends TopRatedBooksState {
  TopRelatedSuccess({required this.books});
  final List<BookEntity> books;
   

}
