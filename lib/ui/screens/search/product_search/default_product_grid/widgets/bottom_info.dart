import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/auth/listeners/auth_bloc_listener.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/price_row.dart';
import 'package:flutter/material.dart';

Widget buildBottomInfo({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
    required double discountedPrice,
    required bool hasDiscount,
  }) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(11, 0, 11, 11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.brand,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              product.productName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.2,
                letterSpacing: -0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            buildDefaultProductGridPriceRow(
              context: context,
              product: product,
              variantIndex: variantIndex,
              discountedPrice: discountedPrice,
              hasDiscount: hasDiscount,
            ),
            const AuthBlocListenerWidget(),
          ],
        ),
      ),
    );
  }
