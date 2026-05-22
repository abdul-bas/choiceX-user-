import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildDefaultBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.successLight,                          
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: AppColors.successBorder),     
    ),
    child: const Text(
      'Default',
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.successText,                        
      ),
    ),
  );
}