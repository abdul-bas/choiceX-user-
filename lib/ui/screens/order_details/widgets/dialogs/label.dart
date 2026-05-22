import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogLabel extends StatelessWidget {
  const DialogLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: AppColors.grey600,                
        letterSpacing: 0.2,
      ),
    );
  }
}