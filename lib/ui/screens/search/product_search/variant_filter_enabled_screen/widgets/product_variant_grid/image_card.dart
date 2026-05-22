import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantCardImage({
  required Uint8List bytes,
  required int discount,
  required bool hasDiscount,
}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(18)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.memory(
            bytes,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.imageErrorBg,
              child: Icon(
                Icons.image_outlined,
                color: AppColors.brandFaint,
                size: 36,
              ),
            ),
          ),
        ),
      ),
      if (hasDiscount)
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.discountBadge,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '-$discount%',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
    ],
  );
}