
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



Widget buildReviewHeader(dynamic onWriteReview) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 3.5,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.brand,                
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Customer Reviews',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.grey800,              
              ),
            ),
          ],
        ),
        if (onWriteReview != null)
          InkWell(                                      
            onTap: onWriteReview,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.ratingScoreBg,          
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.starAmber.withValues(alpha:  0.35), 
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.edit_outlined,
                      size: 13,
                      color: AppColors.ratingScoreText),
                  const SizedBox(width: 5),
                  Text(
                    'Write',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ratingScoreText,  
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
