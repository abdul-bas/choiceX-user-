import 'package:coice/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Center showLoadingIndicator() {
    return Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: 48,
        height: 48,
        child: CircularProgressIndicator(
          color: barndColor,
          strokeWidth: 3,
          backgroundColor: barndColor.withValues(alpha: 0.12),
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Please wait...',
        style: TextStyle(
          color: barndColor.withValues(alpha: 0.7),
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.1,
        ),
      ),
    ],
  ),
);
  }