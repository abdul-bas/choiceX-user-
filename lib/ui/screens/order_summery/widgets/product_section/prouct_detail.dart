 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildProductDetail(String label, String value, IconData icon) {
  return Row(
    children: [
      Text(
        '$label: ',
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.grey600,                           
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.black87,                        
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
