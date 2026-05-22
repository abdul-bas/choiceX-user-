
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
  });

  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextInter(
            text: title,
            fontSize: 18,
            letterSpacing: 0.5,
          ),
          GestureDetector(
            onTap: onSeeAllTap,
            child: TextInter(
              text: 'See All',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.brand,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}