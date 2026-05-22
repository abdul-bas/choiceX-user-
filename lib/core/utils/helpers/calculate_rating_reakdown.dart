
Map<int, int> calculateRatingBreakdown(
  List<Map<String, dynamic>> ratingMap,
) {
  final Map<int, int> breakdown = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
  };

  for (final review in ratingMap) {
    final rating = review['rating'];

    if (rating is num) {
      final roundedRating = rating.round();

      if (breakdown.containsKey(roundedRating)) {
        breakdown[roundedRating] =
            breakdown[roundedRating]! + 1;
      }
    }
  }

  return breakdown;
}
