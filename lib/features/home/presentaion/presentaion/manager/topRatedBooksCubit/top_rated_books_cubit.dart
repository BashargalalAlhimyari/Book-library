import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_top_rated_books_use_case.dart';

part 'top_rated_books_state.dart';

class TopRatedBooksCubit extends Cubit<TopRatedBooksState> {
  final FetchTopRatedBooksUseCase fetchTopRatedBooksUseCase;

  TopRatedBooksCubit(this.fetchTopRatedBooksUseCase) : super(TopRelatedInitial());

  int _nextPage = 1; 
  bool _isLoading = false; 
  final List<BookEntity> _allBooks = [];

  Future<void> fetchTopRatedBooks() async {
    if (_isLoading) return; 
    _isLoading = true;

    if (_nextPage == 1) {
      emit(TopRelatedLoading()); 
    } else {
      emit(TopRelatedPaginationLoading(books: List.from(_allBooks))); 
    }

    var result = await fetchTopRatedBooksUseCase.call(_nextPage);

    result.fold(
      (failure) {
        _isLoading = false; // ✅ مهم جداً لإيقاف اللودنج والسماح بالمحاولة مجدداً
        
        if (_nextPage == 1) {
          emit(TopRelatedFailure(errMessage: failure.message));
        } else {
          emit(TopRelatedPaginationFailure(errMessage: failure.message, books: List.from(_allBooks)));
        }
      },
      (books) {
        _isLoading = false;
        
        // 🛑 التعديل هنا: (Stop Condition)
        // إذا كانت القائمة فارغة، هذا يعني وصلنا للنهاية، لا تزد الصفحة ولا تحدث الـ UI
        if (books.isEmpty) {
            return; 
        }

        // زيادة الصفحة فقط إذا وجدنا بيانات
        _nextPage++; 
        
        _allBooks.addAll(books);
        
        emit(TopRelatedSuccess(books: List.from(_allBooks)));
      },
    );
  }
}