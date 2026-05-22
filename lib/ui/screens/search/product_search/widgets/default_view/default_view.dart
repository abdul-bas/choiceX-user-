 import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/search/product_search/focuse_field/focuse_field.dart';
import 'package:coice/ui/screens/search/product_search/non_focus_view/focus_view.dart';
import 'package:flutter/material.dart';

Widget buildProductSearchDefaultView(ProductSearchController controller) {
  return Column(
    children: [
      Expanded(
        child: controller.isSearchFilterEnabled
            ? FocuseField(
                controller: controller.messageInputCtrl,
                products: controller.productList,
              )
            : NonFocusViewScreen(
                products: controller.productList,
              ),
      ),
    ],
  );
}