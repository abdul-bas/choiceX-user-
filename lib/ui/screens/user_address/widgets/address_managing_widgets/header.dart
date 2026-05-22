import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

AppBar buildAddressHeader(BuildContext context, int count) {
  return AppBar(
    centerTitle: true,
    elevation: 0.01,
    shadowColor: AppColors.black,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_rounded, color: AppColors.black, size: 22),
    ),
    title: const Text(
      'My Addresses',
      style: TextStyle(
        color: AppColors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
    ),
  );
}