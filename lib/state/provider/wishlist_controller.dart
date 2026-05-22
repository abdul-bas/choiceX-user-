import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  List<ProductModel> favoritesList = [];
  List<int> variantIndex = [];

  List<ProductModel> filterFavoritesList = [];
  List<int> filterVariantIndex = [];

  TextEditingController textEditingController = TextEditingController();

  WishlistController() {
    textEditingController.addListener(() {
      setSearchQuery(textEditingController.text);
    });
  }

  void addToWishlist(ProductModel product, int index) {
    bool alreadyExists = false;

    for (int i = 0; i < favoritesList.length; i++) {
      if (favoritesList[i].id == product.id &&
          variantIndex[i] == index) {
        alreadyExists = true;
        break;
      }
    }

    if (!alreadyExists) {
      favoritesList.add(product);
      variantIndex.add(index);

      filterFavoritesList = List.from(favoritesList);
      filterVariantIndex = List.from(variantIndex);

      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    final q = query.toLowerCase();

    if (query.isEmpty) {
      filterFavoritesList = List.from(favoritesList);
      filterVariantIndex = List.from(variantIndex);
    } else {
      filterFavoritesList = [];
      filterVariantIndex = [];

      for (int i = 0; i < favoritesList.length; i++) {
        final e = favoritesList[i];

        bool match =
            e.productName.toLowerCase().contains(q) ||
            e.brand.toLowerCase().contains(q) ||
            e.category.toLowerCase().contains(q) ||
            e.description.toLowerCase().contains(q) ||
            e.model.toLowerCase().contains(q) ||
            e.addedDate.toLowerCase().contains(q);

        if (match) {
          filterFavoritesList.add(e);
          filterVariantIndex.add(variantIndex[i]);
        }
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}