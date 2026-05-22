import 'package:coice/data/models/prodect_model.dart';

List<ProductModel> findCategories({
  required String category,
  required List<ProductModel> products,
}) {
  return products
      .where(
          (element) => element.category.toLowerCase() == category.toLowerCase())
      .toList();
}
