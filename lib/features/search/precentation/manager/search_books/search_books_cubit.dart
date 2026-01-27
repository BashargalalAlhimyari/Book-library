import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:clean_architecture/features/search/domain/useCasees/search_book_use_case.dart';

part 'search_books_cubit_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksCubitState> {
  SearchBooksCubit(this.fetchSearchBooksUseCase) : super(SearchBooksInitial());
  final FetchSearchBooksUseCase fetchSearchBooksUseCase;


  // 1. المتغيرات الداخلية (State Management)
  int _nextPage = 0; // نبدأ من 0 كما اتفقنا
  bool _isLoading = false;
  String _query = ' ';
  final List<SearchBooksEntity> _allBooks = []; // القائمة التراكمية

  Future<void> fetchSearchBooks() async {
    // حماية من التكرار
    if (_isLoading) return;
    _isLoading = true;

    // تحديد نوع التحميل
    if (_nextPage == 0) {
      emit(SearchBooksLoading());
    } else {
      emit(SearchBooksPaginationLoading(books: List.from(_allBooks)));
    }

    // استدعاء اليوزكيس بالصفحة الحالية
    final result = await fetchSearchBooksUseCase.call(FetchSearchBooksParams(pageNumber: _nextPage, query: _query));

    result.fold(
      (failure) {
        _isLoading = false;
        if (_nextPage == 0) {
          emit(SearchBooksFailure(errMessage: failure.message));
        } else {
          emit(
            SearchBooksPaginationFailure(
              errMessage: failure.message,
              books: List.from(_allBooks),
            ),
          );
        }
      },
      (books) {
        _isLoading = false;

        // التحقق من نهاية البيانات
        if (books.isEmpty) return;

        // 2. دمج البيانات (القديم + الجديد) 🌟 هذا هو السطر الأهم
        _allBooks.addAll(books);

        // زيادة الصفحة للمرة القادمة
        _nextPage++;

        // إرسال القائمة الكاملة للواجهة
        emit(SearchBooksSuccess(books: List.from(_allBooks)));
      },
    );
  }


}






