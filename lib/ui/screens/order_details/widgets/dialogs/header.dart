import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    super.key,
    required this.color,
    required this.shadowColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final Color shadowColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 30, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.urbanist(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              color: AppColors.grey500,
            ),
          ),
        ],
      ),
    );
  }
}
