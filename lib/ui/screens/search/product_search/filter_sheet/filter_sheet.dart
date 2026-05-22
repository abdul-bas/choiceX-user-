import 'package:coice/core/constants/ui_string/variant_color.dart';

import 'package:coice/data/models/prodect_model.dart';

import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/bottom_bar/bottom_bar.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/budget_section/budget_section.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/color_section/color_section.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/header/header.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/section_label/section_label.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/widgets/storage_section/storage_section.dart';

import 'package:flutter/material.dart';

class BottomSheetScreenForSearch extends StatelessWidget {
  const BottomSheetScreenForSearch({
    super.key,
    required this.products,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFilterHeader(context),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              children: [
                buildFilterSectionLabel('Budget', const Color(0xFF111827)),
                const SizedBox(height: 12),
                buildBudgetSection(),
                const SizedBox(height: 15),
                buildFilterSectionLabel('Color', const Color(0xFF111827)),
                const SizedBox(height: 14),
                buildColorSection(),
                const SizedBox(height: 15),
                buildFilterSectionLabel('Storage', const Color(0xFF111827)),
                const SizedBox(height: 12),
                buildStorageSection(),
                const SizedBox(height: 12),
              ],
            ),
          ),
          buildFilterBottomBar(context, variantColors, variantColors, products),
        ],
      ),
    );
  }
}
