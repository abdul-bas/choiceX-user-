import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailField extends StatelessWidget {
  const DetailField({
    super.key,
    required this.controller,
    required this.focusColor,
  });

  final TextEditingController controller;
  final Color focusColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 3,
      style: GoogleFonts.urbanist(
        fontSize: 13,
        color: AppColors.textPrimary,                 
      ),
      decoration: InputDecoration(
        hintText: 'Describe the issue (optional)',
        hintStyle: GoogleFonts.urbanist(
          fontSize: 13,
          color: AppColors.grey400,                
        ),
        filled: true,
        fillColor: AppColors.grey50,                    
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey200), 
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor, width: 1.5),
        ),
      ),
    );
  }
}