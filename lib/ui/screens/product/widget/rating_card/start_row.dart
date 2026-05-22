
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildStarRow(double rating, {double size = 18}) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final icon = i < rating.floor()
            ? Icons.star_rounded
            : i < rating
                ? Icons.star_half_rounded
                : Icons.star_outline_rounded;
        return Icon(icon,
            color: AppColors.starAmber, size: size);   
      }),
    );