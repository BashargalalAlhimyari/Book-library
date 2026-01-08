import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/constants/app/app_constants.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_books_use_case.dart';
import 'package:meta/meta.dart';

part 'books_state.dart';
//part 'books_state.dart': تشير إلى أن هذا الملف يعتمد على ملف آخر محدد (في هذه الحالة 'books_state.dart').

class BooksCubitDartCubit extends Cubit<BooksCubitDartState> {
  //BooksCubitDartCubit: كلاس يدير حالة الكتب المميزة باستخدام Cubit من مكتبة BLoC.
  //Cubit<BooksCubitDartState>: يشير إلى أن هذا الكلاس يدير حالات من نوع BooksCubitDartState.
  final FetchBooksUseCase fetchBooksUseCase;
  //final FetchBooksUseCase fetchBooksUseCase: خاصية نهائية (لا يمكن تغييرها بعد التهيئة) من نوع FetchBooksUseCase، والتي تُستخدم لجلب الكتب.
  BooksCubitDartCubit(this.fetchBooksUseCase) : super(BooksCubitDartInitial());
  //في لغة Dart، عندما يرث كلاس من آخر، يجب على الابن أن ينادي مشيّد الأب باستخدام كلمة super.

  Future<void> fetchFeatureBooks({int pageNumber = AppConstants.itemsPerPage}) async {
    if (pageNumber == 0) {
      emit(BooksCubitDartLoading());
      /*
      وظيفة emit هي تغيير الحالة الحالية للـ Cubit وإرسال الحالة الجديدة إلى واجهة المستخدم (UI).
     عندما تنادي emit وتمرر لها BooksCubitDartLoading()، فأنت تخبر التطبيق: "يا واجهة المستخدم، أنا الآن في مرحلة التحميل، قومي بتحديث نفسك فوراً".
       */
    } else {
      emit(BooksCubitPaginationLoading());
    }
    var result = await fetchBooksUseCase.call(pageNumber);
    result.fold(
      (failure) {
        if (pageNumber == 0) {
          emit(BooksCubitDartFailure(errMessage: failure.message));
        } else {
          emit(BooksCubitPaginationFailure(errMessage: failure.message));
        }
      },
      (books) {
        emit(BooksCubitDartSuccess(books: books));
      },
    );
  }
}
