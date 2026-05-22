import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/silver_app_bar/app_bar_baground.dart';
import 'package:flutter/material.dart';

SliverAppBar buildFilterVariantSliverAppBar(
  BuildContext context,
  List<ProductModel> products,
) {
  return SliverAppBar(
    pinned: true,
    expandedHeight: 160,
    backgroundColor: AppColors.white,
    surfaceTintColor: AppColors.transparent,
    elevation: 0,
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back, color: AppColors.white),
    ),
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: buildFilterVariantAppBarBackground(products),
    ),
  );
}