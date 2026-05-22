 
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/silver_app_bar/app_bar_content.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/silver_app_bar/decorative_circles.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantAppBarBackground(List<ProductModel> products) {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.brand, AppColors.brand],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius:
          const BorderRadius.vertical(bottom: Radius.circular(28)),
      boxShadow: [
        BoxShadow(
          color: AppColors.brandShadowMid,
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Stack(
      children: [
        buildFilterVariantDecorativeCircles(),
        buildFilterVariantAppBarContent(products),
      ],
    ),
  );
}