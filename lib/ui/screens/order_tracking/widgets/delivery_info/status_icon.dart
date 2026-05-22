
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.isDelivered});

  final bool isDelivered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,             
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLogo,             
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        isDelivered
            ? Icons.check_circle_rounded
            : Icons.local_shipping_outlined,
        size: 48,
        color: AppColors.brand,                      
      ),
    );
  }
}
