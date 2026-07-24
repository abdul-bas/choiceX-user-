import 'package:choicex/data/models/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

SellerModel toSellerModel(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> sellerDoc) {
 return SellerModel.fromMap(sellerDoc.data!.data() as Map<String, dynamic>);
}
