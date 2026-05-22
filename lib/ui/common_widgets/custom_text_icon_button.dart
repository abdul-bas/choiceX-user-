
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextIconButton extends StatelessWidget {
  const CustomTextIconButton({
    super.key,
    this.function,
    this.radius,
    this.text,
    this.fontWeight,
    this.alignment,
    this.icon,
  });

  final Function()? function;
  final double? radius;
  final String? text;
  final Widget? icon;
  final FontWeight? fontWeight;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        alignment: alignment,
        backgroundColor: const WidgetStatePropertyAll(AppColors.brand), 
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 13),
          ),
        ),
      ),
      onPressed: function,
      icon: icon ?? const Icon(Icons.shopping_cart, color: AppColors.white),
      label: Text(
        text ?? 'Checkout',
        style: TextStyle(
          color: AppColors.white,              
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}