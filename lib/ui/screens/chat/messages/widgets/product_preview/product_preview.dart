import 'dart:convert';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/models/product/variant_model.dart';

import 'package:flutter/material.dart';

Widget messageProductPreview(
    int? variantIndex, ValueNotifier<ProductModel?> product) {
  return ValueListenableBuilder<ProductModel?>(
    valueListenable: product,
    builder: (context, value, _) {
      if (value == null || variantIndex == null) {
        return const SizedBox();
      }

      final variant =
          VariantModel.fromMap(value.variants[variantIndex]);
      final bytes = base64Decode(variant.images.first);

      return Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,                
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowFaint,              
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                bytes,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  color: AppColors.grey200,            
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    size: 20,
                    color: AppColors.textMuted,        
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${variant.price}',
                    style: const TextStyle(
                      color: AppColors.brand,           
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 20),
              onPressed: () => product.value = null,
            ),
          ],
        ),
      );
    },
  );
}
