import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_quick_read_books_use_case.dart';
import 'package:clean_architecture/features/home/presentaion/presentaion/manager/topRatedBooksCubit/top_rated_books_cubit.dart';

part 'quick_read_books_cubit_state.dart';



class QuickReadBooksCubit extends Cubit<QuickReadBooksState> {
  final FetchQuickReadBooksUseCase fetchQuickReadBooksUseCase;

  QuickReadBooksCubit(this.fetchQuickReadBooksUseCase) : super(QuickReadInitial());

  int _nextPage = 1; 
  bool _isLoading = false; 
  final List<BookEntity> _allBooks = [];

  Future<void> fetchQuickBooks() async {
    if (_isLoading) return; 
    _isLoading = true;

    if (_nextPage == 1) {
      emit(QuickReadLoading()); 
    } else {
      emit(QuickReadPaginationLoading(books: List.from(_allBooks))); 
    }

    var result = await fetchQuickReadBooksUseCase.call(_nextPage);

    result.fold(
      (failure) {
        _isLoading = false; // ✅ مهم جداً لإيقاف اللودنج والسماح بالمحاولة مجدداً
        
        if (_nextPage == 1) {
          emit(QuickReadFailure(errMessage: failure.message));
        } else {
          emit(QuickReadPaginationFailure(errMessage: failure.message, books: List.from(_allBooks)));
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
        
        emit(QuickReadSuccess(books: List.from(_allBooks)));
      },
    );
  }
}