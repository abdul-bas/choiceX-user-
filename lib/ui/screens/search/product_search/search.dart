import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/search/product_search/on_chenged_view/on_chenged_view.dart';
import 'package:coice/ui/screens/search/product_search/widgets/app_bar/app_bar.dart';
import 'package:coice/ui/screens/search/product_search/widgets/default_view/default_view.dart';
import 'package:coice/ui/screens/search/product_search/widgets/empty_state/empty_state.dart';
import 'package:coice/core/utils/handlers/product_stream_handler.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    context.read<RecentSearchBloc>().add(RecentSearchGet());
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UiDetailsGet().productGet(),
      builder: (context, snapshot) {
        final resulte = streamHandler(snapshot);
        if (resulte is Widget) {
          return Scaffold(body: resulte);
        }

        return Consumer<ProductSearchController>(
          builder: (context, controller, child) {
            if (!controller.productsInitialized && snapshot.hasData) {
              controller.setProductList(snapshot);
            }

            return PopScope(
              child: Scaffold(
                appBar:
                    buildProductSearchAppBar(controller, focusNode, context),
                body: Consumer<ProductSearchController>(
                  builder: (context, controller, child) {
                    if (controller.messageInputCtrl.text.isNotEmpty &&
                        controller.filteredList.isEmpty) {
                      return buildProductSearchEmptyState(controller);
                    }

                    if (controller.messageInputCtrl.text.isNotEmpty &&
                        controller.filteredList.isNotEmpty) {
                      return OnChengedViewScreen(
                          filteredList: controller.filteredList);
                    }

                    return buildProductSearchDefaultView(controller);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
