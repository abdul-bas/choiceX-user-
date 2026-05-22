import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

toProductModel(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => ProductModel.fromMap(doc.data() as Map<String, dynamic>))
      .toList();
}