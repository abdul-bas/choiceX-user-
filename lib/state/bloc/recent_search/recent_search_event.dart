abstract class RecentSearchEvent {}

class RecentSearchGet extends RecentSearchEvent {}
class RecentActivityGet extends RecentSearchEvent {}

class RecentSearchSet extends RecentSearchEvent {
  String text;
  RecentSearchSet({required this.text});
}

class RecentSearchClear extends RecentSearchEvent {
  int index;
  RecentSearchClear({required this.index});
}

class RecentSearchClearAll extends RecentSearchEvent {}

class RecentActivityEvent extends RecentSearchEvent {
  String productId;
  String variantIndex;
  RecentActivityEvent({required this.productId,required this.variantIndex});
}
