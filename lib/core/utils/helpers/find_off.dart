import 'package:coice/data/models/prodect_model.dart';

int findOFF(List<ProductModel> products) {
  int maxOFF = 0;

  for (var product in products) {
    for (var variant in product.variants) {
      final int discount = int.tryParse(variant['Discount'].toString()) ?? 0;

      if (discount > maxOFF) {
        maxOFF = discount;
      }
    }
  }

  return maxOFF;
}

