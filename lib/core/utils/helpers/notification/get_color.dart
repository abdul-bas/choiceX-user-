
  import 'dart:ui';

import 'package:flutter/material.dart';

Color getNotificationIconColor(String type) {
    switch (type) {
      case 'order':
        return Colors.blue;
      case 'delivery':
        return Colors.green;
      case 'payment':
        return Colors.purple;
      case 'offer':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
