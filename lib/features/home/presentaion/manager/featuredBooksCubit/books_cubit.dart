import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_books_use_case.dart';
import 'package:meta/meta.dart';

part 'books_state.dart';

class BooksCubitDartCubit extends Cubit<BooksCubitDartState> {
  BooksCubitDartCubit(this.fetchBooksUseCase) : super(BooksCubitDartInitial());

  final FetchBooksUseCase fetchBooksUseCase;

  Future<void> fetchFeatureBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(BooksCubitDartLoading());
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
