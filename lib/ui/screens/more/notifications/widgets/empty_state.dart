
  import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildNotificationEmptyState() {                
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_none_rounded,
          size: 80,
          color: AppColors.grey300,                    
        ),
        const SizedBox(height: 16),
        Text(
          "You're all caught up!",
          style: GoogleFonts.inter(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          "No new notifications",
          style: GoogleFonts.inter(
              fontSize: 14, color: AppColors.grey500), 
        ),
      ],
    ),
  );
}
