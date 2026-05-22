abstract class PageEvent {}
class ToggleIndex extends PageEvent {
  int index;
  ToggleIndex({required this.index});
}