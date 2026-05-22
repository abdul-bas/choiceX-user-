
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddressCheckoutHeader extends StatelessWidget {
  const AddressCheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.brandSubtle.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_on,
            color: AppColors.brandSubtle,
            size: 28,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Add Delivery Address',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textNavy,
          ),
        ),
      ],
    );
  }
}
