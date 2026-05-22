
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class DeliveryDecorCircle extends StatelessWidget {
  const DeliveryDecorCircle({super.key, 
    this.top, this.bottom, this.left, this.right,
    required this.size,
    required this.opacity,
  });

  final double? top, bottom, left, right;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white.withValues(alpha: opacity),
        ),
      ),
    );
  }
}