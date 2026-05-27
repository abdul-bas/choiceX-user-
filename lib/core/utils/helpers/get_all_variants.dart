import 'package:coice/data/models/prodect_model.dart';

List<Map<String, dynamic>> getAllVariant(List<ProductModel> products) {
  List<Map<String, dynamic>> allVariant = [];
  for (var product in products) {
    for (int variantIndex = 0;
        variantIndex < product.variants.length;
        variantIndex++) {
          
      allVariant.add({'productId': product.id, 'variantIndex': variantIndex});
    }
  }
  return allVariant;
}

List<Map<String, dynamic>> getRecentVariants(List<ProductModel> products) {
  products.sort((a, b) =>
      a.addedDate.compareTo(b.addedDate));

  List<Map<String, dynamic>> allVariant = [];

  for (var product in products) {
    for (int i = 0; i < product.variants.length; i++) {
      allVariant.add({
        'productId': product.id,
        'variantIndex': i,
      });
    }
  }

  return allVariant;
}
DateTime parseDate(String date) {
  final parts = date.split('/');
  return DateTime(
    int.parse(parts[2]), // year
    int.parse(parts[1]), // month
    int.parse(parts[0]), // day
  );
}