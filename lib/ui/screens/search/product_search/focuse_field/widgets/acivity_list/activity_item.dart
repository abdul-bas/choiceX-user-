 import 'dart:typed_data';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';
Widget buildActivityItem({
  required BuildContext context,
  required ProductModel product,
  required int variantIndex,
  required Uint8List bytes,
  required double discountedPrice,
  required int discount,
  required bool hasDiscount,
}) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(
          product: product,
          variantIndex: variantIndex,
        ),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 76,
              height: 76,
              child: Image.memory(bytes, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    color: AppColors.textDeep,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${product.productType} · ${product.model}',
                  style: const TextStyle(
                    color: AppColors.textCoolGrey,
                    fontSize: 11.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Rs. ${discountedPrice.toInt()}',
                      style: const TextStyle(
                        color: AppColors.brand,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        height: 1,
                      ),
                    ),
                    if (hasDiscount) ...[
                      const SizedBox(width: 6),
                      Text(
                        'Rs. ${product.variants[variantIndex]['price']}',
                        style: const TextStyle(
                          color: AppColors.priceStrike,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.discountBadge,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '-$discount%',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.brandFaint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 15,
              color: AppColors.brandMuted,
            ),
          ),
        ],
      ),
    ),
  );
}