import 'package:flutter/material.dart';

IconData getAddressIcon(String? nickname) {
  switch (nickname?.toLowerCase()) {
    case 'home':
      return Icons.home_rounded;
    case 'work':
    case 'office':
      return Icons.business_rounded;
    default:
      return Icons.location_on_rounded;
  }
}
