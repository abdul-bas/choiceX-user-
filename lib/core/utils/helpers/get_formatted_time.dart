   import 'package:intl/intl.dart';

String getFormatTime(DateTime time) {
    if (time.millisecondsSinceEpoch == 0) return '';
    return DateFormat('HH:mm').format(time);
  }