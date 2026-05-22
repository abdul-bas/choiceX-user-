  
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildSectionLabel(String label) {
  return Row(
    children: [
      Container(
        width: 3,
        height: 16,
        decoration: BoxDecoration(
          color: AppColors.brand,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          color: AppColors.textDeep,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.2,
        ),
      ),
    ],
  );
}