part of 'navigate_cubit.dart';


sealed class NavigateState {
  int  selectedIndex=0;
  NavigateState({required this.selectedIndex});
}

final class MoveTo extends NavigateState {
  MoveTo({required super.selectedIndex});
}
