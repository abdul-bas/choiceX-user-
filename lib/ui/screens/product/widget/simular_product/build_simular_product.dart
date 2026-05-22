
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/state/provider/simular_product_state.dart';
import 'package:coice/ui/screens/product/widget/simular_product/product_simular_card.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/core/utils/utils/snapshot_handler_without_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BuildSimilarProduct extends StatelessWidget {
  const BuildSimilarProduct({
    super.key,
    required this.product,
    required this.variantIndex,
  });

  final ProductModel product;
  final int variantIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UiDetailsGet().getSimilarProducts(
        category: product.category,
      ),
      builder: (context, snapshot) {
        final result = handleSnapshotWithOutIndicator(snapshot);
        if (result != null) return result;

        final similarProducts = snapshot.data;

        
        if (similarProducts == null || similarProducts.isEmpty) {
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          context
              .read<SimilarProductState>()
              .loadProducts(similarProducts, variantIndex);
        });

        return Consumer<SimilarProductState>(builder: (context, value, child) {
          if (value.allSimilarVariants.isEmpty) {
          return const SizedBox.shrink();
        }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInter(
                text: 'Similar Products',
                fontSize: 16,
                letterSpacing: 0.5,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 233,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.allSimilarVariants.length,
                  itemBuilder: (context, index) {
                    final item = value.allSimilarVariants[index];
                    return buildProductCard(
                      context,
                      item['product'],
                      item['variantIndex'],
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
