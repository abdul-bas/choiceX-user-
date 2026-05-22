import 'package:coice/data/local/shared_pref_service/recent_activities/recent_activities.dart';
import 'package:coice/data/local/shared_pref_service/recent_search/recent_search.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:coice/state/bloc/recent_search/recent_search_init.dart';
import 'package:coice/state/bloc/recent_search/recent_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchBloc extends Bloc<RecentSearchEvent, RecentSearchState> {
  final RecentSearch _recentSearch = RecentSearch();
  final RecentActivities _activity = RecentActivities();
  RecentSearchBloc() : super(RecentSearchInit()) {
    on<RecentSearchSet>((event, emit) async {
      final result = await _recentSearch.recentSearchSet(event.text);
      emit(result);
    });
    
    on<RecentSearchClear>((event, emit) async {
      final result = await _recentSearch.recentSearchClear(event.index);
      emit(result);
    });
    on<RecentSearchClearAll>((event, emit) async {
      final result = await _recentSearch.recentSearchesClearAll();
      emit(result);
    }); on<RecentActivityEvent>((event, emit) async {
      final result = await _activity.setRecentActivity(productId:event.productId ,variantIndex:event.variantIndex );
      emit(result);
    });
    on<RecentSearchGet>((event, emit) async {
  final searchList = await _recentSearch.recentSearchGet();
   final activityList = await _activity.getRecentActivities();

  emit(RecentSearchLoaded(
    searches: searchList,
    activities: activityList,
  ));
});
    
  }
}
