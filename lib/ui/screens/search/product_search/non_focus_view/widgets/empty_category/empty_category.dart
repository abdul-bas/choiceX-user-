
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildNonFocusEmptyCategory() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.brandFaint,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.search_off_rounded,
            size: 36,
            color: AppColors.brand.withValues(alpha: 0.45),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'No Products Found',
          style: TextStyle(
            color: AppColors.textDeep,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Try selecting a different category',
          style: TextStyle(
            color: AppColors.textCoolGrey,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}