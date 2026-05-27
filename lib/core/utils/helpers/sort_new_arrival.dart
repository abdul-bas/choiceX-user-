import 'package:coice/data/models/prodect_model.dart';

List<ProductModel> sortNewArrival(List<ProductModel> products) {
  final sortedList = List<ProductModel>.from(products);

  sortedList.sort((a, b) {
    final dateA =a.addedDate;
    final dateB = b.addedDate;

    return dateB.compareTo(dateA);
  });

  return sortedList;
}
