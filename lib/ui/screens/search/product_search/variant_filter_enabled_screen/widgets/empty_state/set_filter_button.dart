 import 'package:coice/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildSetFiltersButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: barndColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: barndColor.withValues(alpha: 0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.tune_rounded,
                color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Set Filters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }