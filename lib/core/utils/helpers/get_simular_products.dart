import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/core/utils/parsers/to_product_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

List<ProductModel> getSimularProduct({
  required AsyncSnapshot<QuerySnapshot> snapshot,
  required ProductModel product,
}) {
  final List<ProductModel> products = toProductModel(snapshot);
  final List<ProductModel> similarProducts = [];

 
  products.sort(
    (a, b) =>
        DateTime.parse(b.addedDate).compareTo(DateTime.parse(a.addedDate)),
  );

  for (final pro in products) {
    
    if (pro.id == product.id) continue;

    if (pro.category == product.category) {
      final proDate = DateTime.parse(pro.addedDate);
      final productDate = DateTime.parse(product.addedDate);

      if (proDate.isAfter(productDate) ||
          proDate.isAtSameMomentAs(productDate)) {
        similarProducts.add(pro);
      }
    }

    
    if (similarProducts.length >= 15) {
      return similarProducts;
    }
  }

  return similarProducts;
}
