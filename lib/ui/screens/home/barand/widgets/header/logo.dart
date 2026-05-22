
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, required this.brandName}); 

  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.brandLogoGradient,    
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDialog,
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          brandName.isNotEmpty ? brandName[0].toUpperCase() : '?',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}
