import 'package:intl/intl.dart';

String getFormattedAmount(double amount) {
  return NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  ).format(amount);
}
