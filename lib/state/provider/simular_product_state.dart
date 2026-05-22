import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

class SimilarProductState extends ChangeNotifier {
  List<Map<String, dynamic>> allSimilarVariants = [];

  
  void loadProducts(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> similarProducts,
    int variantIndex,
  ) {
    allSimilarVariants.clear();

    for (final item in similarProducts) {
      final product = ProductModel.fromMap(item.data());

      for (int i = 0; i < product.variants.length; i++) {
       
        if (i == variantIndex) continue;

        allSimilarVariants.add({
          'product': product,
          'variantIndex': i,
        });
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    allSimilarVariants.clear(); 
    super.dispose();
  }
}
