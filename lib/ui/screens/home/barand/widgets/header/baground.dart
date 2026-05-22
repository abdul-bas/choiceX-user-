import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/home/barand/widgets/header/decorative_circle.dart';
import 'package:coice/ui/screens/home/barand/widgets/header/info.dart';
import 'package:coice/ui/screens/home/barand/widgets/header/logo.dart';
import 'package:flutter/material.dart';

class BrandHeaderBackground extends StatelessWidget {
  const BrandHeaderBackground({super.key, required this.brandName});

  final String brandName;

 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 + MediaQuery.of(context).padding.top,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.brandHeaderGradient,   
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          DecorativeCircle(top: -55,  right: -45,  size: 210, opacity: 0.07),
          DecorativeCircle(bottom: -30, left: -65, size: 230, opacity: 0.05),
          DecorativeCircle(top: 90,   right: 110,  size: 50,  opacity: 0.08),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Row(
                    children: [
                      BrandLogo(brandName: brandName),
                      const SizedBox(width: 16),
                      Expanded(child: BrandInfo(brandName: brandName)),
                    ],
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}