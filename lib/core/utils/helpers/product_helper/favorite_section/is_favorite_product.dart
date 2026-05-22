bool isFavoriteProduct(
  Map<String, dynamic>? data,
  String productId,
  int variantIndex,
) {
  if (data == null) return false;

  final List favorites = data['favorites'] ?? [];

  return favorites.any(
    (fav) =>
        fav['productId'] == productId &&
        fav['variantIndex'] == variantIndex,
  );
}
