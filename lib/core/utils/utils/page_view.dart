import 'package:coice/state/bloc/page_index/page_state.dart';

class PageViewIndex {
 Future<PageState> togglePageView(int index) async {
    try {
      return ToggleIndexSuccess(index: index);
    } catch (e) {
      return ToggleIndexFailure(massage: 'Unexpected error $e');
    }
  }
}
