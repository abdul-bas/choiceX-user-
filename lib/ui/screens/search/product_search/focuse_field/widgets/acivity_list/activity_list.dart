


import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/controller/controller.dart';
import 'package:coice/ui/screens/search/product_search/focuse_field/widgets/acivity_list/activity_item.dart';

import 'package:flutter/material.dart';
Widget buildActivityList(
  BuildContext context,
  List<Map<String, dynamic>> activity,
  List<ProductModel> products,
) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: activity.length,
    separatorBuilder: (_, __) =>
        const SizedBox(height: 10),
    itemBuilder: (context, index) {
      final data = activity[index];

      final product =
          SearchLogic.getProduct(products: 
       products,
        item: data,
      );

      final variantIndex =
          SearchLogic.getVariantIndex(data);

      final bytes =
          SearchLogic.decodeImage(
        product,
        variantIndex,
      );

      final discountedPrice =
          SearchLogic.getDiscountedPrice(
        product: product,
        variantIndex: variantIndex,
      );

      final discount =
          SearchLogic.getDiscount(
        product: product,
        variantIndex: variantIndex,
      );

      final hasDiscount =
          SearchLogic.hasDiscount(
        discount,
      );

      return buildActivityItem(
        context: context,
        product: product,
        variantIndex: variantIndex,
        bytes: bytes,
        discountedPrice: discountedPrice,
        discount: discount,
        hasDiscount: hasDiscount,
      );
    },
  );
}