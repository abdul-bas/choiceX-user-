import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_tracking/controller/controller.dart';
import 'package:coice/ui/screens/order_tracking/widgets/delivery_info/delivery_decor_circle.dart';
import 'package:coice/ui/screens/order_tracking/widgets/delivery_info/order_id_row.dart';
import 'package:coice/ui/screens/order_tracking/widgets/delivery_info/status_badge.dart';
import 'package:coice/ui/screens/order_tracking/widgets/delivery_info/status_icon.dart';
import 'package:flutter/material.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final isDelivered = OrderTrackingLogic.isDelivered(order);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.brand,                    
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
        
          DeliveryDecorCircle(
            top: -10, right: -10,
            size: 120,
            opacity: 0.10,                         
          ),
          DeliveryDecorCircle(
            bottom: -20, left: -20,
            size: 80,
            opacity: 0.20,                          
          ),

         
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                StatusIcon(isDelivered: isDelivered),
                const SizedBox(height: 20),
                StatusBadge(order: order, isDelivered: isDelivered),
                const SizedBox(height: 16),
                OrderIdRow(order: order),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
