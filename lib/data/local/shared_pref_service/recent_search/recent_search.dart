import 'package:coice/state/bloc/recent_search/recent_search_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearch {
  Future<RecentSearchState> recentSearchSet(String text) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final serchList = prefs.getStringList('search') ?? [];
      if (!serchList.contains(text)) {
        serchList.add(text);
      }
      if (serchList.length > 7) {
        serchList.removeAt(0);
      }
      await prefs.setStringList('search', serchList);

      return RecentSearchSuccessGet(result: serchList);
    } catch (e) {
      return RecentSearchError();
    }
  }

  Future<List<String>> recentSearchGet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serchList = prefs.getStringList('search');
      return serchList??[];
    } catch (e) {
      return [];
    }
  }

  Future<RecentSearchState> recentSearchClear(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final serchList = prefs.getStringList('search') ?? [];
      serchList.removeAt(index);
      await prefs.setStringList('search', serchList);

      return RecentSearchSuccessGet(result: serchList);
    } catch (e) {
      return RecentSearchError();
    }
  }

  Future<RecentSearchState> recentSearchesClearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('search');

      return RecentSearchSuccess();
    } catch (e) {
      return RecentSearchError();
    }
  }
}
