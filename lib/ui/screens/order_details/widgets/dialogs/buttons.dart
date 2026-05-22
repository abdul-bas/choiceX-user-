import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DialogButtons extends StatelessWidget {
  const DialogButtons({
    super.key,
    required this.cancelLabel,
    required this.confirmLabel,
    required this.confirmColor,
    required this.shadowColor,
    required this.onCancel,
    required this.onConfirm,
  });

  final String cancelLabel;
  final String confirmLabel;
  final Color confirmColor;
  final Color shadowColor;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onCancel,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.grey100,              
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  cancelLabel,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey600,          
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onConfirm,
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: confirmColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  confirmLabel,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,           
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}