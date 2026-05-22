import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BrandEmptyState extends StatelessWidget {
  const BrandEmptyState({super.key, required this.brandName});

  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.storefront_outlined,
              size: 44,
              color: AppColors.borderLight,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No products from',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            brandName.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.textDark,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new arrivals',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
