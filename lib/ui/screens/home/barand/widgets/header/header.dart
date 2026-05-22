import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/home/barand/widgets/header/baground.dart';
import 'package:coice/ui/screens/home/controller/controller.dart';
import 'package:flutter/material.dart';


class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, required this.brandName});

  final String brandName;

  

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130 + MediaQuery.of(context).padding.top,
      pinned: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back, color: AppColors.white),   
      ),
      actions: [
        GestureDetector(
          onTap: () =>HomeLogic.navigateToCart(context),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.white,                                   
          ),
        ),
        const SizedBox(width: 15),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(16),
        background: BrandHeaderBackground(brandName: brandName),
      ),
    );
  }
}

