 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/dialog/filter_dialog.dart';
import 'package:flutter/material.dart';

Widget buildProductSearchFilterButton(
  ProductSearchController controller,
  BuildContext context,
) {
  return Visibility(
    visible: controller.isSearchFilterEnabled,
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () => filterFunction(
          context: context,
          product: controller.productList,
        ),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.grey200),
          ),
          child: const Icon(
            Icons.tune_rounded,
            color: AppColors.inputHint,
            size: 20,
          ),
        ),
      ),
    ),
  );
}