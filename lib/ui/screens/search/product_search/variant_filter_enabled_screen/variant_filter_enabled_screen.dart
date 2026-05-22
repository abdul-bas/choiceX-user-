
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/ui/screens/cart/listeners/cart_listener.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/empty_state/empty_state.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/product_variant_grid/product_variant_grid.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/silver_app_bar/silver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VariantFilterEnabledScreen extends StatelessWidget {
  const VariantFilterEnabledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductSearchController>(
      builder: (context, value, child) {
        final products = value.productList;
        final variants = value.allVariants;

        return addCartListener(
          child: Scaffold(
            backgroundColor: AppColors.surfacePageGrey,
            body: variants.isEmpty
                ? buildFilterVariantEmptyState(context)
                : CustomScrollView(
                    slivers: [
                      buildFilterVariantSliverAppBar(context, products),
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverToBoxAdapter(
                          child: ProductVariantGrid(
                            products: products,
                            allVariant: variants,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
