import 'package:coice/data/models/prodect_model.dart';

findProduct(
    {required List<ProductModel> products,
    required Map<String, dynamic> item}) {
  return products.firstWhere((element) => element.id == item['productId']);
}