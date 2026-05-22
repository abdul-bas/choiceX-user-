import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/widget/bottom_bar/price_and_add_to_cart_widget.dart';
import 'package:flutter/material.dart';

Widget buildBottomBar(int value, ProductModel product, int quantity) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.surfaceWhite,               
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowDark,               
          blurRadius: 12,
          offset: const Offset(0, -3),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(1, 10, 1, 12),
    child: PriceAndAddToCartWidget(
      product: product,
      value: value,
      quentity: quantity,
    ),
  );
}