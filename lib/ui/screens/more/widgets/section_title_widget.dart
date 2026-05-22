 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.grey700,                   
            letterSpacing: 0.8,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.grey300,                   
            height: 20,
            thickness: 1,
            indent: 15,
          ),
        ),
      ],
    ),
  );
}