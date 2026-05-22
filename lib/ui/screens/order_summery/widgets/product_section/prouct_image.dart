  import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildProductImage(Uint8List bytes) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.grey200, width: 1),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.memory(bytes, height: 80, width: 80, fit: BoxFit.cover),
    ),
  );
}
