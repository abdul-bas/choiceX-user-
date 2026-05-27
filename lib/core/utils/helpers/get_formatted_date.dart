import 'package:intl/intl.dart';
String getFormattedDate(DateTime? date) {
  if (date == null) return '';
  return DateFormat('dd-MM-yyyy').format(date);
}