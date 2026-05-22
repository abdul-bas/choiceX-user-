import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/core/utils/parsers/to_product_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';
class ProductSearchController extends ChangeNotifier {
  int filterTagsIndex = 0;
  bool isSearchFilterEnabled = false;

  List<ProductModel> productList = [];
  List<ProductModel> categoryList = [];
  List<ProductModel> filteredList = [];

  bool productsInitialized = false;

  final TextEditingController messageInputCtrl =
      TextEditingController();

  List<Map<String, dynamic>> allVariants = [];

  void filterFocus(bool value) {
    isSearchFilterEnabled = value;
    notifyListeners();
  }

  void suggestions(
      List<ProductModel> productList,
      String text,
      ) {
    if (text.isEmpty) {
      filteredList = productList;
    } else {
      final query = text.toLowerCase();

      filteredList = productList.where((element) {
        return element.productName.toLowerCase().contains(query) ||
            element.productType.toLowerCase().contains(query) ||
            element.brand.toLowerCase().contains(query) ||
            element.category.toLowerCase().contains(query) ||
            element.model.toLowerCase().contains(query) ||
            element.warranty.toLowerCase().contains(query);
      }).toList();
    }

    notifyListeners();
  }

  void setAllVariants(
    String? selectedColor,
    String? selectedStorage,
    Map<String, int>? selectedBudget,
    List<ProductModel> product,
  ) {
    allVariants.clear();

    final Set<String> addedKeys = {};

    for (final p in product) {
      for (int i = 0; i < p.variants.length; i++) {
        final v = p.variants[i];

        final String? variantColor = v['color'];
        final String? variantStorage = v['storage'];
        final int variantPrice =
            int.tryParse(v['price'] ?? '') ?? 0;

        bool matches = true;

        if (selectedColor != null &&
            selectedColor != variantColor) {
          matches = false;
        }

        if (selectedStorage != null &&
            selectedStorage != variantStorage) {
          matches = false;
        }

        if (selectedBudget != null &&
            (variantPrice < selectedBudget['min']! ||
                variantPrice > selectedBudget['max']!)) {
          matches = false;
        }

        if (matches) {
          final key = '${p.id}-$i';

          if (addedKeys.add(key)) {
            allVariants.add({
              'productId': p.id,
              'variantIndex': i,
            });
          }
        }
      }
    }

    notifyListeners();
  }

  List<ProductModel> setProductList(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
  ) {
    productList = toProductModel(snapshot);

    productsInitialized = true;

    categoryList = productList;

    return productList;
  }

  void setCategoryIndexAndProduct(
    int index,
    List<ProductModel> list,
    String category,
  ) {
    filterTagsIndex = index;

    final selected = category.toLowerCase();

    categoryList = selected == 'all'
        ? list
        : list.where(
            (e) =>
                e.category.toLowerCase() ==
                selected,
          ).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    messageInputCtrl.dispose();
    super.dispose();
  }
}