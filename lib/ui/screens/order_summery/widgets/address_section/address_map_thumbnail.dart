
  import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildAddressMapThumbnail() {
  return Container(
    height: 90,
    width: 90,
    decoration: BoxDecoration(
      color: AppColors.black,                          
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        const Center(
          child: Icon(
            Icons.location_on,
            color: AppColors.danger,                           
            size: 36,
          ),
        ),
      ],
    ),
  );
}