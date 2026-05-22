import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/date_formate.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/core/utils/helpers/get_formatted_id.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_details/widgets/payment_card/payment_row.dart';

import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.items});

  final OrderModel items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Payment Details',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          PaymentRow(label: 'Payment Type', value: items.paymentMethod),
          PaymentRow(label: 'Payment Status', value: items.paymentStatus),
          PaymentRow(
              label: 'Amount Paid', value: getFormattedAmount(items.amount)),
          PaymentRow(
              label: 'Payment Date & Time', value: dateFormate(items.date)),
          PaymentRow(
              label: 'Transaction ID',
              value: groupedTxn(items.orderId),
              fontSize: 11),
        ],
      ),
    );
  }
}
