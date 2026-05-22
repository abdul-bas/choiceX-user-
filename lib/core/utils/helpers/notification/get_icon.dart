
  import 'package:flutter/material.dart';

IconData getNotificationIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag_outlined;
      case 'delivery':
        return Icons.local_shipping_outlined;
      case 'payment':
        return Icons.payment_outlined;
      case 'offer':
        return Icons.local_offer_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }