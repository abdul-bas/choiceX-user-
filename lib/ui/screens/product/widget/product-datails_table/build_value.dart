import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/enums/spec_kind.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildValue(dynamic item) {
  if (item.kind == SpecKind.discount) {
    return Row(
      children: [
        Text(
          '₹${item.value}',
          style: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.successText,            
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.successLight,             
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.successText
                  .withValues(alpha:  0.25),                
            ),
          ),
          child: Text(
            'OFFER',
            style: GoogleFonts.dmSans(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppColors.successText,            
            ),
          ),
        ),
      ],
    );
  }

  if (item.kind == 'price') {
    return Text(
      '₹${item.value}',
      style: GoogleFonts.dmSans(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.specValueMuted,               
        decoration: TextDecoration.lineThrough,
      ),
    );
  }

  return Text(
    item.value,
    maxLines: 4,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.dmSans(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,                    
    ),
  );
}