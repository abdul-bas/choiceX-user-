

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

ProductModel? toParticularProduct(
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
) {
  if (!snapshot.hasData) return null;

  final doc = snapshot.data!;
  final data = doc.data();

  if (!doc.exists || data == null) return null;

  return ProductModel.fromMap(data);
}
