
  import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/product/widget/rating_card/start_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildScorePanel(double avg, int total) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.ratingScoreBg,              
            border: Border.all(
              color: AppColors.starAmber.withValues(alpha:  0.3), 
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.starAmber.withValues(alpha:  0.15), 
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              avg.toStringAsFixed(1),
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.ratingScoreText,       
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        buildStarRow(avg, size: 15),
        const SizedBox(height: 5),
        Text(
          '$total ${total == 1 ? 'review' : 'reviews'}',
          style: GoogleFonts.inter(
              fontSize: 11,
              color: AppColors.grey500,              
              fontWeight: FontWeight.w500),
        ),
      ],
    );