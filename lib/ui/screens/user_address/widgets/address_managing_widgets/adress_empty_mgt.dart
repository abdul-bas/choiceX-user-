 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildEmpty() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 86,
          height: 86,
          decoration: BoxDecoration(
            color: AppColors.notificationUnreadBg,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.location_off_outlined,
            color: AppColors.addressCheckTick,
            size: 38,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'No addresses yet',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Add your first delivery location',
          style: TextStyle(color: AppColors.textDark, fontSize: 13.5),
        ),
      ],
    ),
  );
}
