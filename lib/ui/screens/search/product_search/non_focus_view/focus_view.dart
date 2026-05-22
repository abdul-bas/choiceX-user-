
import 'package:coice/core/utils/helpers/get_all_variants.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/product_search/default_product_grid/default_product-grid.dart';
import 'package:coice/ui/screens/search/product_search/non_focus_view/widgets/category_tabs/category_tabs.dart';
import 'package:coice/ui/screens/search/product_search/non_focus_view/widgets/empty_category/empty_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NonFocusViewScreen extends StatelessWidget {
  const NonFocusViewScreen({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        buildNonFocusCategoryTabs(products),
        const SizedBox(height: 8),
        Expanded(
          child: Consumer<ProductSearchController>(
            builder: (context, value, child) {
              if (value.categoryList.isEmpty) {
                return buildNonFocusEmptyCategory();
              }
              return DefaultProductGrid(
                products: value.categoryList,
                allVariant: getAllVariant(value.categoryList),
              );
            },
          ),
        ),
      ],
    );
  }
}
