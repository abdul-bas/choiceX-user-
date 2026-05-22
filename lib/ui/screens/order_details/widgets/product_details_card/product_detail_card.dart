import 'dart:convert';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_details/widgets/product_details_card/info_chip.dart';
import 'package:flutter/material.dart';

class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({super.key, required this.items});

  final OrderModel items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,             
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,           
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 90,
              height: 90,
              color: AppColors.grey200,              
              child: Image.memory(
                base64Decode(items.images),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  items.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Model: ${items.model}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.grey700,           
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    InfoChip(label: 'Color', value: items.color),
                    const SizedBox(width: 8),
                    InfoChip(label: 'Qty', value: '${items.quantity}'),
                    const Spacer(),
                    Text(
                      getFormattedAmount(items.amount),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
