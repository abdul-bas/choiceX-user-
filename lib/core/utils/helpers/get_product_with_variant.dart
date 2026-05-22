import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

Map<String, dynamic>? getProductWithVariant(
  AsyncSnapshot<QuerySnapshot> snapshot,
  Map<String, dynamic> cartItem,
) {
  final docs = snapshot.data?.docs;
  if (docs == null || docs.isEmpty) return null;

  
  QueryDocumentSnapshot? productDoc;
  for (var doc in docs) {
    if (doc['id'] == cartItem['productId']) {
      productDoc = doc;
      break;
    }
  }

  if (productDoc == null) return null;

  final model =
      ProductModel.fromMap(productDoc.data() as Map<String, dynamic>);

  final int variantIndex =
      int.tryParse(cartItem['variantIndex']?.toString() ?? "") ?? 0;

  
  if (variantIndex < 0 || variantIndex >= model.variants.length) {
    return null;
  }

  final variant = model.variants[variantIndex];

  return {
    "model": model,
    "variant": variant,
    "variantIndex": variantIndex,
  };
}



