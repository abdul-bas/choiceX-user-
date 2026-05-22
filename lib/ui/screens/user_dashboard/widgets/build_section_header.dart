import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

Widget buildSectionHeader({
  required String title,
  VoidCallback? onSeeAllTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextInter(
          text: title,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: TextInter(
            text: 'See All',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: barndColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    ),
  );
}







