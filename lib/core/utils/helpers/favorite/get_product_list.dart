import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';
ProductModel? getProductList(
    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> productDocs) {

  if (productDocs.data == null) return null;

  final product = productDocs.data!.data();

  if (product == null) return null;

  return ProductModel.fromMap(product);
}