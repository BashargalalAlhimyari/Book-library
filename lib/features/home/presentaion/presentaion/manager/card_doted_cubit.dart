// ملف الكيوبت فقط (بدون ملف state منفصل)
import 'package:flutter_bloc/flutter_bloc.dart';

class CardDotedCubit extends Cubit<int> {
  CardDotedCubit() : super(0); 

  void changeCardDoted(int index) {
    emit(index); 
  }
}