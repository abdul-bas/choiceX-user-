 
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/date_formate.dart';
import 'package:coice/data/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildReviewItem(ReviewDataModel review) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: AppColors.surfaceLight,                    
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.grey200),      
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.reviewAvatarBg, 
              child: Text(
                review.userName.substring(0, 1).toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.reviewAvatarText,    
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    review.email,
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.grey600),      
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            size: 13,
                            color: AppColors.starAmber,
                          );
                        }),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateFormate(DateTime.parse(review.date)),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppColors.grey600,     
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (review.review.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            review.review,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.grey700,               
              height: 1.5,
            ),
          ),
        ],
      ],
    ),
  );
}