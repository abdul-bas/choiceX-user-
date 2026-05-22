import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/models/order_model.dart';

import 'package:coice/data/models/prodect_model.dart';

Map<String, dynamic> getProduct(
  List<OrderModel> items,
  List<QueryDocumentSnapshot>? docs,
) {
  
  if (docs == null || docs.isEmpty) {
    return {
      "products": <ProductModel>[],
      "variantIndexes": <int>[],
      
    };
  }

  final String userId = AuthRepository().getUeserId();

  
  final List<ProductModel> products = docs
      .map((e) => ProductModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  
  final Map<String, ProductModel> productMap = {
    for (var product in products) product.id: product
  };

  List<ProductModel> matchedProducts = [];
  List<int> variantIndexes = [];
  
  
  for (var item in items) {
   
    if (item.userId != userId) continue;

   
    final product = productMap[item.productId];
    if (product == null) continue;

    int index = item.variantIndex;

    
    if (index < 0 || index >= product.variants.length) continue;

    
    matchedProducts.add(product);
    variantIndexes.add(index);
   
  }

  return {
    "products": matchedProducts,
    "variantIndexes": variantIndexes,
   
  };
}
