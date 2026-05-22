import 'package:coice/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildFilterSectionLabel(String label, Color? ink) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: barndColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label,
            style:  TextStyle(
              color: ink,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            )),
      ],
    );
  }
