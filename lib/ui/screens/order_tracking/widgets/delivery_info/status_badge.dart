

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/order/get_status_message.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_tracking/controller/controller.dart';
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.order, required this.isDelivered});

  final OrderModel order;
  final bool isDelivered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.15),  
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.30), 
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,       
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            getStatusMessage(order.itemStatus),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.white,              
              letterSpacing: 0.3,
            ),
          ),
          if (!isDelivered) ...[
            const SizedBox(height: 8),
            Text(
              'Expected: ${OrderTrackingLogic.formattedExpectedDate(order)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.onImageWhiteStrong, 
                letterSpacing: 0.2,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
