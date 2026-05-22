import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/search/product_search/filter_sheet/filter_sheet.dart';
import 'package:flutter/material.dart';

filterFunction({
  required BuildContext context,
  required List<ProductModel> product,
}) {
  showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return BottomSheetScreenForSearch(
          products: product,
          scrollController: scrollController,
        );
      },
    ),
  );
}