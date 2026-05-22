
double calculateAverageRating(List<Map<String, dynamic>> ratingMap) {
  if (ratingMap.isEmpty) return 0.0;

  double total = 0.0;
  int count = 0;

  for (var review in ratingMap) {
    final rating = review['rating'];

    if (rating is num) {
      total += rating.toDouble();
      count++;
    }
  }

  return count == 0 ? 0.0 : total / count;
}

