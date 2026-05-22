
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_id.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderIdRow extends StatelessWidget {
  const OrderIdRow({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.receipt_long_rounded,
          size: 16,
          color: AppColors.white.withValues(alpha: 0.7), 
        ),
        const SizedBox(width: 8),
        Text(
          'Order ID: ',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.onImageWhiteMid,     
            letterSpacing: 0.3,
          ),
        ),
        Text(
          groupedTxn(order.orderId),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.white,                 
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}