import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:coice/ui/screens/order/widgets/order_empty_widget.dart';
import 'package:coice/ui/screens/order/widgets/order_product_tile.dart';

import 'package:flutter/material.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key, required this.ordersDoc});

  final List<QueryDocumentSnapshot<Object?>> ordersDoc;

  @override
  Widget build(BuildContext context) {
    final active = OrderController.filterActive(ordersDoc); 
    if (active.isEmpty) return const OrdersEmptyState();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: active.length,
        itemBuilder: (context, index) {
          final order = OrderController.parseOrder(active[index]); 
          return OrderProductTile(items: order);
        },
      ),
    );
  }
}