import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/constants/app/app_constants.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_newest_use_case.dart';
import 'package:meta/meta.dart';

part 'news_books_state.dart';

class NewsBooksCubit extends Cubit<NewsBooksState> {
  NewsBooksCubit(this.fetchNewestUseCase) : super(NewsBooksInitial());

  final FetchNewestUseCase fetchNewestUseCase;

  Future<void> fetchNewsBooks({int pageNumber = AppConstants.itemsPerPage}) async {
    if (pageNumber == 0) {
      emit(NewsBooksLoading());
    } else {
      emit(NewsBooksCubitPaginationLoading());
    }
    var result = await fetchNewestUseCase.call( pageNumber);
    result.fold((failure) {
      if (pageNumber == 0) {
        emit(NewsBooksFailure(errMessage: failure.message));
      } else {
        emit(NewsBooksCubitPaginationFailure(errMessage: failure.message));
      }
    },
     (books) => emit(NewsBooksSuccess(books: books)));
  }
}
