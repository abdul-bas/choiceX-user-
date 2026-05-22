import 'package:coice/core/utils/utils/page_view.dart';
import 'package:coice/state/bloc/page_index/page_event.dart';
import 'package:coice/state/bloc/page_index/page_int.dart';
import 'package:coice/state/bloc/page_index/page_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PageViewBloc extends Bloc<PageEvent, PageState> {
  PageViewIndex pageView = PageViewIndex();
  PageViewBloc() : super(PageInt()) {
    on<ToggleIndex>((event, emit) async {
      final resulte = await pageView.togglePageView(event.index);
      emit(resulte);
    });
  }
}
