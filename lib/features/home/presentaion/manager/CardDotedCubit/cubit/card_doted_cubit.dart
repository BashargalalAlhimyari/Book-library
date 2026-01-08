import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_doted_state.dart';

class CardDotedCubit extends Cubit<CardDotedState> {
  CardDotedCubit() : super(CardDotedExtend(selectedIndex: 0));

  void changeCardDoted(int index) {
    emit(CardDotedExtend(selectedIndex: index));
  }
}
