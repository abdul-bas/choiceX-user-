import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/seller_model.dart';
import 'package:flutter/material.dart';

SellerModel toSellerModel(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> sellerDoc) {
 return SellerModel.fromMap(sellerDoc.data!.data() as Map<String, dynamic>);
}
