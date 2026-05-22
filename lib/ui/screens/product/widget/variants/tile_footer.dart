import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TileFooter extends StatelessWidget {
  const TileFooter({
    super.key,
    required this.colorLabel,
    required this.swatch,
    required this.discounted,
    required this.originalPrice,
  });

  final String colorLabel;
  final Color swatch;
  final double discounted;
  final dynamic originalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: swatch,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  colorLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: swatch.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹${discounted.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black87,             
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '₹$originalPrice',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.dangerBorder,        
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}