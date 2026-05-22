import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/product/widget/variants/tile_footer.dart';
import 'package:coice/ui/screens/product/widget/variants/tile_image.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';

class VariantTile extends StatelessWidget {
  const VariantTile({
    super.key,
    required this.variant,
    required this.swatch,
    required this.isSelected,
    required this.onTap,
    this.bytes,
  });

  final Map<dynamic, dynamic> variant;
  final Uint8List? bytes;
  final Color swatch;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double discounted = afterProductDiscount(
      discount: variant['discount'],
      price: variant['price'],
    );
    final String colorLabel =
        variant['color']?.toString() ?? 'N/A';

    return InkWell(                                    
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: 110,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.surfaceWhite,                
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: swatch.withValues(alpha: 0.1), 
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.shadowFaint,       
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
          border: Border.all(
            color: isSelected
                ? swatch.withValues(alpha: 0.2)         
                : AppColors.grey200,                    
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              TileImage(bytes: bytes, swatch: swatch),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TileFooter(
                  colorLabel: colorLabel,
                  swatch: swatch,
                  discounted: discounted,
                  originalPrice: variant['price'],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: swatch,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: AppColors.white,            
                      size: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}