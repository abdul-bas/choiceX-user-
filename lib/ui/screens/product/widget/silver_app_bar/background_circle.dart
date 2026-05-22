
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundCircle extends StatelessWidget {
  const BackgroundCircle({
    super.key,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.brandSubtle,                 
        ),
      ),
    );
  }
}