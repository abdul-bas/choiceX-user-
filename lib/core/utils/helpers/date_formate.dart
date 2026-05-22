import 'package:intl/intl.dart';

String dateFormate(DateTime date) {
 
  return DateFormat('dd , MMM yyyy').format(date);
}
