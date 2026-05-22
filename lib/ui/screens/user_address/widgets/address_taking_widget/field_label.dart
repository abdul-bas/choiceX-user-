import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddressFieldLabel extends StatelessWidget {
  const AddressFieldLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.orderShopBtnText,
        letterSpacing: 0.1,
      ),
    );
  }
}

