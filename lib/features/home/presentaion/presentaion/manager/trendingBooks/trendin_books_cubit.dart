import 'package:bloc/bloc.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_newest_use_case.dart';
import 'package:clean_architecture/features/home/domain/user_cases/fetch_trending_books_use_case.dart';
import 'package:flutter/foundation.dart';

part 'trendin_books_state.dart';

class TrendingBooksCubit extends Cubit<TrendingBooksState> {
  TrendingBooksCubit(this.fetchTrendingBooksUseCase)
    : super(TrendingBooksInitial());

  final FetchTrendingBooksUseCase fetchTrendingBooksUseCase;

  // 1. المتغيرات الداخلية (State Management)
  int _nextPage = 0; // نبدأ من 0 كما اتفقنا
  bool _isLoading = false;
  final List<BookEntity> _allBooks = []; // القائمة التراكمية

  Future<void> fetchTrendingBooks() async {
    // حماية من التكرار
    if (_isLoading) return;
    _isLoading = true;

    // تحديد نوع التحميل
    if (_nextPage == 0) {
      emit(TrendingBooksLoading());
    } else {
      emit(TrendingBooksPaginationLoading(books: List.from(_allBooks)));
    }

    // استدعاء اليوزكيس بالصفحة الحالية
    var result = await fetchTrendingBooksUseCase.call(_nextPage);
     
    result.fold(
      (failure) {
        _isLoading = false;
        if (_nextPage == 0) {
          emit(TrendingBooksFailure(errMessage: failure.message));
        } else {
          emit(TrendingBooksPaginationFailure(errMessage: failure.message, books: List.from(_allBooks)));
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
        emit(TrendingBooksSuccess(books: List.from(_allBooks)));
      },
    );
  }
}
