import 'package:bloc/bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

part 'pdf_search_state_state.dart';

class PdfSearchCubit extends Cubit<PdfSearchState> {
  PdfSearchCubit() : super(PdfSearchInitial());

  PdfTextSearchResult? _currentResult;

  // 1. بدء البحث
  void startSearch(String query, PdfViewerController controller) {
    if (query.isEmpty) return;
    
    // تنفيذ البحث عبر الكونترولر
    _currentResult = controller.searchText(query);
    
    emit(PdfSearchLoaded(_currentResult!, refreshId: DateTime.now().millisecondsSinceEpoch));
  }

  // 2. النتيجة التالية
  void nextInstance() {
    if (_currentResult != null) {
      _currentResult!.nextInstance();
      _emitRefresh();
    }
  }

  // 3. النتيجة السابقة
  void previousInstance() {
    if (_currentResult != null) {
      _currentResult!.previousInstance();
      _emitRefresh();
    }
  }

  // 4. إغلاق البحث
  void clearSearch() {
    _currentResult?.clear();
    _currentResult = null;
    emit(PdfSearchInitial());
  }

  // دالة مساعدة لتحديث الواجهة (لأن الكائن نفسه لا يتغير في الذاكرة)
  void _emitRefresh() {
    if (_currentResult != null) {
      emit(PdfSearchLoaded(_currentResult!, refreshId: DateTime.now().millisecondsSinceEpoch));
    }
  }
}