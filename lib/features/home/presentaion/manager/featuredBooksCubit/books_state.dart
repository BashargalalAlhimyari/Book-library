part of 'books_cubit.dart';
// part of: تشير إلى أن هذا الملف هو جزء من ملف آخر محدد (في هذه الحالة 'books_cubit.dart').
@immutable
//@immutable: تشير إلى أن جميع خصائص الكلاس غير قابلة للتغيير بعد إنشائه.
sealed class BooksCubitDartState {}
//sealed class: يسمح بالوراثة داخل نفس الملف فقط ويمنعها خارجه.

final class BooksCubitDartInitial extends BooksCubitDartState {}
//final class: يمنع أي كلاس آخر من الوراثة منه (Extending) تماماً، حتى داخل نفس الملف.

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
