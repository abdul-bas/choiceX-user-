import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:coice/ui/screens/order/widgets/history_empty_widget.dart';
import 'package:coice/ui/screens/order/widgets/order_product_tile.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, required this.ordersDoc});

  final List<QueryDocumentSnapshot<Object?>> ordersDoc;

  @override
  Widget build(BuildContext context) {
    final delivered =
        OrderController.filterDelivered(ordersDoc);            
    if (delivered.isEmpty) return const HistoryEmptyState();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: delivered.length,
        itemBuilder: (context, index) {
          final order =
              OrderController.parseOrder(delivered[index]);     
          return OrderProductTile(
            items: order,
            complete: 'Received Order',
          );
        },
      ),
    );
  }
}