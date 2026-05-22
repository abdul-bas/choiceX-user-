
String formatDateLabel(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  if (date == today) return 'Today';
  if (date == yesterday) return 'Yesterday';

  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  // Show year only if it's not the current year
  if (date.year != now.year) {
    return '${date.day} ${months[date.month]} ${date.year}';
  }
  return '${date.day} ${months[date.month]}';
}
