abstract class RecentSearchState {}

class RecentSearchSuccess extends RecentSearchState {}

class RecentSearchSuccessGet extends RecentSearchState {
  List<String>? result;
  RecentSearchSuccessGet({required this.result});
}



class RecentSearchError extends RecentSearchState {}
class RecentSearchLoaded extends RecentSearchState {
  final List<String> searches;
  final List<Map<String, dynamic>> activities;

  RecentSearchLoaded({
    required this.searches,
    required this.activities,
  });
}