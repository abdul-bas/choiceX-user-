
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddressDivider extends StatelessWidget {
  final bool isDefault;
  const AddressDivider({super.key, required this.isDefault});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDefault
                ? [
                    AppColors.transparent,
                    AppColors.brand.withValues(alpha: 0.15),
                    AppColors.transparent,
                  ]
                : [
                    AppColors.transparent,
                    AppColors.black.withValues(alpha: 0.15),
                    AppColors.transparent,
                  ],
          ),
        ),
      ),
    );
  }
}