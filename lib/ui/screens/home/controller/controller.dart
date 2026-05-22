

import 'package:coice/core/utils/helpers/find_categories.dart';
import 'package:coice/core/utils/helpers/get_all_variants.dart';
import 'package:coice/core/utils/helpers/sort_new_arrival.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/common_widgets/ProductBrowseGrid.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:flutter/material.dart';



class HomeLogic {
  
  static List<ProductModel> getNewArrivals(List<ProductModel> products) {
    return sortNewArrival(products);
  }

 
  static  List<Map<String, dynamic>> getLimitedVariants(
    List<ProductModel> products, {
    int limit = 4,
  }) {
    final variants = getAllVariant(products);
    return variants.length > limit ? variants.sublist(0, limit) : variants;
  }


  static List<ProductModel> getProductsByCategory({
    required String category,
    required List<ProductModel> products,
  }) {
    return findCategories(category: category, products: products);
  }

  
  static int getBrandCount(List<dynamic> docs, {int max = 5}) {
    return docs.length >= max ? max : docs.length;
  }
 static void navigateToCart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyCartPage()),
    );
  }
  static void navigateToNewArrivals(
    BuildContext context,
    List<ProductModel> newArrivals,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductBrowseGrid(
          products: newArrivals,
          text: 'New Arrivals',
        ),
      ),
    );
  }

}