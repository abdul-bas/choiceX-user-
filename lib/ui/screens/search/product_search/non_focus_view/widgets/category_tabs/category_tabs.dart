import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/ui/screens/search/product_search/non_focus_view/widgets/category_tabs/category_chip.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';

Widget buildNonFocusCategoryTabs(List<ProductModel> products) {
  return StreamBuilder(
    stream: UiDetailsGet().categoryGet(),
    builder: (context, asyncSnapshot) {
      final state = handleSnapshot(asyncSnapshot);
      if (state != null) return state;
      if (asyncSnapshot.data == null) return const SizedBox();

      final categories = asyncSnapshot.data!.docs;
      final List<Map<String, dynamic>> categoriesIncludeAll = [
        {'name': 'All'},
        ...categories.map((e) => e.data() as Map<String, dynamic>),
      ];

      return SizedBox(
        height: 42,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categoriesIncludeAll.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final data = categoriesIncludeAll[index];
            final tag = data['name'] ?? '';
            return buildNonFocusCategoryChip(
                context, index, tag, data, products);
          },
        ),
      );
    },
  );
}