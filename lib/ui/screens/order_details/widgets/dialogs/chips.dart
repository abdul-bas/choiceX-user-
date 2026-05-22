

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ReasonChips extends StatelessWidget {
  const ReasonChips({
    super.key,
    required this.reasons,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  final List<String> reasons;
  final String selected;
  final Color selectedColor;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: reasons.map((reason) {
        final isSelected = selected == reason;
        return GestureDetector(
          onTap: () => onTap(reason),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: isSelected ? selectedColor : AppColors.grey100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? selectedColor : AppColors.grey300,
              ),
            ),
            child: Text(
              reason,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.grey700,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
