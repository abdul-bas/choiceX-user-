abstract class PageState {}

class ToggleIndexSuccess extends PageState {
  int index;
  ToggleIndexSuccess({required this.index});
}

class ToggleIndexFailure extends PageState {
  String massage;
  ToggleIndexFailure({required this.massage});
}
