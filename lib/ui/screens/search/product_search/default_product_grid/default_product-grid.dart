import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/utils/helpers/find_product.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/bottom_info.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/discount_badge.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/full_bleed_image.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/scrim.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/widgets/wishlist_button.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';

class DefaultProductGrid extends StatelessWidget {
  const DefaultProductGrid({
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
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 24),
      shrinkWrap: true,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      itemCount: allVariant.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.58,
      ),
      itemBuilder: (context, index) {
        final item = allVariant[index];
        final variantIndex = item['variantIndex'];
        final product = findProduct(item: item, products: products);
        final Uint8List bytes =
            base64Decode(product.variants[variantIndex]['images'][0]);
        final discountedPrice = afterProductDiscount(
          discount: product.variants[variantIndex]['discount'],
          price: product.variants[variantIndex]['price'],
        );
        final int discount =
            int.parse(product.variants[variantIndex]['discount']);
        final bool hasDiscount = discount > 0;

        return GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                      product: product, variantIndex: variantIndex),
                )),
            child: Stack(
              children: [
                buildFullBleedImage(bytes),
                buildScrim(),
                if (hasDiscount) buildDiscountBadge(discount),
                buildWishlistButton(),
                buildBottomInfo(
                  context: context,
                  product: product,
                  variantIndex: variantIndex,
                  discountedPrice: discountedPrice,
                  hasDiscount: hasDiscount,
                ),
              ],
            ));
      },
    );
  }
}
