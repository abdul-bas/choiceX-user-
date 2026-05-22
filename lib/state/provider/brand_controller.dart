

import 'package:coice/core/utils/helpers/get_all_variants.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';


class BrandController extends ChangeNotifier {
  BrandController({
    required String brandName,
    required List<ProductModel> allProducts,
  }) {
    _init(brandName: brandName, allProducts: allProducts);
  }

  
  List<ProductModel> _brandProducts = [];
  List<Map<String, dynamic>> _allVariants = [];

  
  List<ProductModel> get brandProducts => _brandProducts;
  List<Map<String, dynamic>> get allVariants => _allVariants;
  bool get isEmpty => _brandProducts.isEmpty;

  
  void _init({
    required String brandName,
    required List<ProductModel> allProducts,
  }) {
    _brandProducts = allProducts
        .where((e) => e.brand.toLowerCase() == brandName.toLowerCase())
        .toList();
    _allVariants = getAllVariant(_brandProducts);
  }
}