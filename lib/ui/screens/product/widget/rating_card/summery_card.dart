import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/product/widget/rating_card/break_down_bars.dart';
import 'package:coice/ui/screens/product/widget/rating_card/score_panel.dart';
import 'package:flutter/material.dart';

Widget buildSummaryCard(
  double avg,
  int total,
  Map<int, int> breakdown,
) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,                   
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey100),    
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,              
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildScorePanel(avg, total),
          const SizedBox(width: 16),
          Container(
              width: 1, height: 100, color: AppColors.grey100), 
          const SizedBox(width: 16),
          Expanded(child: buildBreakdownBars(breakdown, total)),
        ],
      ),
    );