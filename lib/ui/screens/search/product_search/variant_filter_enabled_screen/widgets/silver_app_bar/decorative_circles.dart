 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantDecorativeCircles() {
  return Stack(
    children: [
      Positioned(
        top: -20,
        right: -20,
        child: Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white10,
          ),
        ),
      ),
      Positioned(
        bottom: 10,
        left: -30,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white6,
          ),
        ),
      ),
    ],
  );
}
