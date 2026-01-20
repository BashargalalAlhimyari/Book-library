import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/features/home/domain/entity/book_entity.dart';

class SelectedBookCubit extends Cubit<BookEntity?> {
  // الحالة الابتدائية null (لا يوجد كتاب مختار)
  SelectedBookCubit() : super(null);

  void selectBook(BookEntity book) {
    emit(book);
  }
}