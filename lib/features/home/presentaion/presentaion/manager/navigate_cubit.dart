import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class NavigateCubit extends Cubit<int> {
  NavigateCubit() : super(0);


  void moveToIndex(int index) {
    emit(index);
  }
}
