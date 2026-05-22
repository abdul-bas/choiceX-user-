
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoReviewsState extends StatelessWidget {
  const NoReviewsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,              
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),   
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.ratingScoreBg,            
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_outline_rounded,
              color: AppColors.starAmber,                
              size: 30,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No Reviews Yet',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,           
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Be the first to share your experience\nwith this product.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.grey500,               
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}