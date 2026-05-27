import 'package:coice/state/bloc/recent_search/recent_search_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentActivities {
  Future<RecentSearchState> setRecentActivity(
      {required String productId, required String variantIndex}) async {
    try {
      final pref = await SharedPreferences.getInstance();
      List<String> recentList = pref.getStringList('RecentActivities') ?? [];
      final String newActivity = '$productId|$variantIndex';
      if (!recentList.contains(newActivity)) {
        recentList.insert(0, newActivity);
      }
      if (recentList.length > 5) {
        recentList = recentList.take(5).toList();
      }
      await pref.setStringList('RecentActivities', recentList);
     
      return RecentSearchSuccess();
    } catch (e) {
     
      return RecentSearchError();
    }
  }

  Future<List<Map<String, dynamic>>> getRecentActivities() async {
    try {
      final pref = await SharedPreferences.getInstance();
      List<String> list = pref.getStringList('RecentActivities') ?? [];
      final activity = list.map((e) {
        final parts = e.split('|');
        return {
          'productId': parts[0],
          'variantIndex': parts[1],
        };
      }).toList();
      
      return activity;
    } catch (e) {
     
      return [];
    }
  }
}
