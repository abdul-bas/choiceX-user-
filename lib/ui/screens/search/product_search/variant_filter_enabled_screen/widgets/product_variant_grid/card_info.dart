 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/auth/listeners/auth_bloc_listener.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/product_variant_grid/price_row.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantCardInfo({
  required BuildContext context,
  required ProductModel product,
  required int variantIndex,
  required double discountedPrice,
  required bool hasDiscount,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.brand,
            style: const TextStyle(
              color: AppColors.inputHint,
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            product.productName,
            style: const TextStyle(
              color: AppColors.textDeep,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: -0.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          buildFilterVariantPriceRow(
            context: context,
            product: product,
            variantIndex: variantIndex,
            discountedPrice: discountedPrice,
            hasDiscount: hasDiscount,
          ),
          const SizedBox(height: 4),
          AuthBlocListenerWidget(),
        ],
      ),
    ),
  );
}
