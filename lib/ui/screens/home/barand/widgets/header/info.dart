
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BrandInfo extends StatelessWidget {
  const BrandInfo({super.key, required this.brandName});

  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brandName,
          style: const TextStyle(
            color: AppColors.white,                     
            fontSize: 23,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_rounded,
              color: AppColors.onImageWhiteStrong,      
              size: 12,
            ),
            const SizedBox(width: 5),
            Text(
              'Official Brand',
              style: TextStyle(
                color: AppColors.onImageWhiteStrong,   
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}