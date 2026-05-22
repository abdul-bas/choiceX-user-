double productDiscountPrice({
  required String discount,
  required String price,
}) {
  final double originalPrice = double.tryParse(price.trim()) ?? 0.0;

  double discountPercent = double.tryParse(discount.trim()) ?? 0.0;

  if (discountPercent < 0) discountPercent = 0;
  if (discountPercent > 100) discountPercent = 100;

  final double discountedPrice = originalPrice * (1 - discountPercent / 100);
  print('$discountedPrice................................');

  return double.parse(discountedPrice.toStringAsFixed(2));
}
