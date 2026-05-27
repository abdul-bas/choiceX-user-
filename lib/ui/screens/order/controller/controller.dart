import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/repository/order_repository.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/screens/order/my_orders.dart';
import 'package:coice/ui/screens/order_details/order_detail_screen.dart';
import 'package:coice/ui/screens/order_tracking/order_taraking_screen.dart';
import 'package:coice/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';

class OrderController {
  OrderController._();

  static Stream<dynamic> getOrdersStream() => UiDetailsGet().ordersGet();

  static List<dynamic> filterActive(List<dynamic> docs) => docs
      .where((d) => d['itemStatus'].toString().toLowerCase() != 'delivered')
      .toList();

  static List<dynamic> filterDelivered(List<dynamic> docs) => docs
      .where((d) => d['itemStatus'].toString().toLowerCase() == 'delivered')
      .toList();

  static OrderModel parseOrder(dynamic doc) =>
      OrderModel.fromMap(doc.data() as Map<String, dynamic>);

  static Future<void> clearCart() => AuthRepository().deleteCart();

  static void goToOrderDetail(BuildContext context, OrderModel order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OrderDetailScreen(items: order)),
    );
  }

  static void goToOrderTracking(BuildContext context, OrderModel order) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OrderTrackingScreen(order: order)),
    );
  }

  static void goToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyCartPage()),
    );
  }

  static void goToOrdersAfterPlacing(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const OrdersScreen()),
      (route) => route.isFirst,
    );
  }

  static void goToDashboard(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen()),
      (route) => false,
    );
  }
  
}
