import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigate_state.dart';

class NavigateCubit extends Cubit<NavigateState> {
  NavigateCubit() : super(MoveTo(selectedIndex: 0));


  void moveToIndex(int index) {
    emit(MoveTo(selectedIndex: index));
  }
}
