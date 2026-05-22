import 'package:intl/intl.dart';



String getFormattedDate(String date) {
  final DateTime parsedDate = DateTime.parse(date);
  return DateFormat('EEE, dd MMM').format(parsedDate);
}
