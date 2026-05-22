import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

Widget buildTitleRow(int value, dynamic product) {
  final bool inStock = product.status == 'Live';

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: TextInter(
          text: product.productName,
          letterSpacing: 0.4,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          maxLines: 3,
          overFlow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: inStock
              ? AppColors.success.withValues(alpha: 0.05) 
              : AppColors.danger.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: inStock
                ? AppColors.success.withValues(alpha: 0.1)
                : AppColors.danger.withValues(alpha: 0.1),
            width: 0.8,
          ),
        ),
        child: TextInter(
          letterSpacing: 0.3,
          text: inStock ? 'In Stock' : 'Out of Stock',
          color: inStock
              ? AppColors.success                      
              : AppColors.danger,                       
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    ],
  );
}