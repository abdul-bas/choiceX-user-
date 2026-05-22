int priceMultiplication({
  required String amount,
  required int quantity,
}) {
  final price = int.tryParse(amount) ?? 0;
  return price * quantity;
}

