part of 'card_doted_cubit.dart';

sealed class CardDotedState {
  int selectedIndex = 0;
  CardDotedState({required this.selectedIndex});
}

final class CardDotedExtend extends CardDotedState {
  CardDotedExtend({required super.selectedIndex});
}


