import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/product_image_slider.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';

SliverAppBar buildSliverAppBar(
  BuildContext context,
  int value,
  ProductModel product,
  ValueNotifier<int> indcatorIndex,
) {
  return SliverAppBar(
    expandedHeight: 449,
    pinned: true,
    floating: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.surfaceLight,            
    surfaceTintColor: AppColors.transparent,            
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
    ),
    title: TextSlab(
      text: 'Product Details',
      letterSpacing: 0.5,
      fontSize: 20,
    ),
    centerTitle: true,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          tooltip: 'My Cart',
          onPressed: () => ProductController.goToCart(context), 
          icon: const Icon(
            Icons.shopping_cart_outlined,
            size: 22,
            color: AppColors.black87,                  
          ),
        ),
      ),
    ],
    flexibleSpace: FlexibleSpaceBar(
      background: ProductImageSlider(
        product: product,
        value: value,
        indcatorIndex: indcatorIndex,
      ),
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
    ),
  );
}