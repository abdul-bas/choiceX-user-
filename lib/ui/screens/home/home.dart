import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/home/controller/controller.dart';
import 'package:coice/ui/screens/home/widgets/categories_section/categories_section.dart';
import 'package:coice/ui/screens/home/widgets/featured_banner/featured_banner.dart';
import 'package:coice/ui/screens/home/widgets/header/header.dart';
import 'package:coice/ui/common_widgets/all_product_variant_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
   
    final newArrivals = HomeLogic.getNewArrivals(products);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedBanner(products: newArrivals),
            const SizedBox(height: 28),
            HomeCategoriesSection(products: products),
            SectionHeader(
              title: 'New Arrivals',
              onSeeAllTap: () =>
                  HomeLogic.navigateToNewArrivals(context, newArrivals),
            ),
            AllProductVariantGrid(
              allVariant: HomeLogic.getLimitedVariants(newArrivals),
              products: newArrivals,
              physics: const NeverScrollableScrollPhysics(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
