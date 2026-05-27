import 'package:coice/core/constants/app_colors/app_colors.dart';

import 'package:coice/data/models/prodect_model.dart';

import 'package:coice/ui/screens/search/controller/controller.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/product_variant_grid/card_info.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/product_variant_grid/image_card.dart';
import 'package:flutter/material.dart';

class ProductVariantGrid extends StatelessWidget {
  const ProductVariantGrid({
    super.key,
    required this.products,
    required this.allVariant,
    this.physics,
  });

  final List<ProductModel> products;
  final List<Map<String, dynamic>> allVariant;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      itemCount: allVariant.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.60,
      ),
      itemBuilder: (context, index) {
        final item = allVariant[index];

        final int variantIndex = SearchLogic.getVariantIndex(
          item,
        );

        final product = SearchLogic.getProduct(
          item: item,
          products: products,
        );
        if (product == null) return SizedBox();
        final bytes = SearchLogic.getImageBytes(
          product: product,
          variantIndex: variantIndex,
        );

        final discountedPrice = SearchLogic.getDiscountedPrice(
          product: product,
          variantIndex: variantIndex,
        );

        final discount = SearchLogic.getDiscount(
          product: product,
          variantIndex: variantIndex,
        );

        final hasDiscount = SearchLogic.hasDiscount(
          discount,
        );

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            SearchLogic.navigateToDetails(
              context,
              product,
              variantIndex,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.grey300,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowFaint5,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFilterVariantCardImage(
                  bytes: bytes,
                  discount: discount,
                  hasDiscount: hasDiscount,
                ),
                buildFilterVariantCardInfo(
                  context: context,
                  product: product,
                  variantIndex: variantIndex,
                  discountedPrice: discountedPrice,
                  hasDiscount: hasDiscount,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
