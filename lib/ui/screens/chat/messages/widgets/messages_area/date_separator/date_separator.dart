
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class DateSeparator extends StatelessWidget {
  const DateSeparator({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppColors.grey300, height: 1)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.grey200,               
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.grey700,              
                letterSpacing: 0.3,
              ),
            ),
          ),
          const Expanded(child: Divider(color: AppColors.grey300, height: 1)),
        ],
      ),
    );
  }
}