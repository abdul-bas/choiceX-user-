import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/provider/brand_controller.dart';
import 'package:coice/ui/screens/home/barand/widgets/empty_widget/empty_widget.dart';
import 'package:coice/ui/screens/home/barand/widgets/header/header.dart';
import 'package:coice/ui/screens/home/barand/widgets/sort_row/sort_row.dart';
import 'package:coice/ui/common_widgets/brand_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrandDetailScreen extends StatelessWidget {
  const BrandDetailScreen({
    super.key,
    required this.brandName,
    required this.products,
  });

  final String brandName;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BrandController(
        brandName: brandName,
        allProducts: products,
      ),
      child: _BrandDetailView(brandName: brandName),
    );
  }
}

class _BrandDetailView extends StatelessWidget {
  const _BrandDetailView({required this.brandName});

  final String brandName;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BrandController>();

    if (controller.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: BrandEmptyState(brandName: brandName),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surfaceOffWhite,
      body: CustomScrollView(
        slivers: [
          BrandHeader(brandName: brandName),
          SliverToBoxAdapter(
            child: BrandSortRow(
              brandName: brandName,
              productCount: controller.brandProducts.length,
            ),
          ),
          SliverToBoxAdapter(
            child: BrandGridView(
              products: controller.brandProducts,
              allVariant: controller.allVariants,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
