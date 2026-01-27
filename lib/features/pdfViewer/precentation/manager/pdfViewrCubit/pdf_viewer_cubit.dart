import 'package:flutter_bloc/flutter_bloc.dart';
import 'pdf_viewer_state.dart';

class PdfViewerCubit extends Cubit<PdfViewerState> {
  PdfViewerCubit() : super(const PdfViewerState());

  // تحديث رقم الصفحة
  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  // تحديث عدد الصفحات الكلي (عند التحميل)
  void setTotalPages(int total) {
    emit(state.copyWith(totalPages: total));
  }

  // تبديل الوضع الليلي
  void toggleNightMode() {
    emit(state.copyWith(isNightMode: !state.isNightMode));
  }
}