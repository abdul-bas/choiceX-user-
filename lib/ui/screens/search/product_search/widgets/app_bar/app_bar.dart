import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/search/product_search/widgets/app_bar/filter_button.dart';
import 'package:coice/ui/screens/search/product_search/widgets/app_bar/search_field.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildProductSearchAppBar(
  ProductSearchController controller,
  FocusNode? focusNode,
  BuildContext context,
) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.surfacePageGrey,
    elevation: 0,
    titleSpacing: 0,
    title: Focus(
      focusNode: focusNode,
      onFocusChange: controller.filterFocus,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
        child: Row(
          children: [
            buildProductSearchSearchField(controller, context),
            buildProductSearchFilterButton(controller, context),
          ],
        ),
      ),
    ),
  );
}