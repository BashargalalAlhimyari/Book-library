import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/search/domain/entity/search_books_entity.dart';
import 'package:clean_architecture/features/search/domain/useCasees/search_book_use_case.dart'; // تأكد من الاسم useCases

part 'search_books_cubit_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksCubitState> {
  SearchBooksCubit(this.fetchSearchBooksUseCase) : super(SearchBooksInitial());
  final FetchSearchBooksUseCase fetchSearchBooksUseCase;

  // 1. المتغيرات الداخلية
  // 1. المتغيرات الداخلية
  int _nextPage = 0;
  bool _isLoading = false;
  final List<SearchBooksEntity> _allBooks = [];
  String _currentQuery = "";

  // --- دالة البحث الجديدة (تستدعى عند الكتابة) ---
  void search(String query) {
    _currentQuery = query; // Update current query
    if (query.isEmpty) {
      _currentQuery = "";
      _allBooks.clear();
      _nextPage = 0;
      emit(SearchBooksInitial());
      return;
    }
    _nextPage = 0; // تصفير الصفحة
    _allBooks.clear(); // مسح النتائج القديمة
    // لا نحتاج للتحقق من is_Loading هنا لأننا نريد إلغاء البحث القديم وبدء جديد
    fetchSearchBooks();
  }

  // --- دالة جلب البيانات (تستدعى للبحث وللـ Pagination) ---
  Future<void> fetchSearchBooks() async {
    if (_isLoading) return;
    _isLoading = true;

    // تحديد نوع التحميل
    if (_nextPage == 0) {
      emit(SearchBooksLoading());
    } else {
      emit(SearchBooksPaginationLoading(books: List.from(_allBooks)));
    }

    final result = await fetchSearchBooksUseCase.call(
      FetchSearchBooksParams(pageNumber: _nextPage, query: _currentQuery),
    );

    result.fold(
      (failure) {
        _isLoading = false;
        if (_nextPage == 0) {
          emit(SearchBooksFailure(errMessage: failure.message));
        } else {
          emit(
            SearchBooksPaginationFailure(
              errMessage: failure.message,
              books: List.from(_allBooks), // نحافظ على الكتب القديمة
            ),
          );
        }
      },
      (books) {
        _isLoading = false;

        // 🌟 تعديل مهم: إذا كانت القائمة فارغة في أول صفحة، نعرض أنها فارغة
        if (books.isEmpty && _nextPage == 0) {
          _allBooks.clear(); // للتأكيد
          emit(SearchBooksSuccess(books: [])); // قائمة فارغة للواجهة
          return;
        }

        // إذا كانت فارغة في الصفحات التالية (وصلنا للنهاية)
        if (books.isEmpty) return;

        _allBooks.addAll(books);
        _nextPage++; // تجهيز الصفحة التالية

        emit(SearchBooksSuccess(books: List.from(_allBooks)));
      },
    );
  }
}
