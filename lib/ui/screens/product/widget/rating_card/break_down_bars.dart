import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildBreakdownBars(Map<int, int> breakdown, int total) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final star = 5 - i;
        final count = breakdown[star] ?? 0;
        final pct = total > 0 ? count / total : 0.0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 10,
                child: Text(
                  '$star',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey600,        
                  ),
                ),
              ),
              const SizedBox(width: 3),
              const Icon(Icons.star_rounded,
                  size: 11, color: AppColors.starAmber),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.grey100,      
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: pct,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.ratingGradStart,
                              AppColors.ratingGradEnd,   
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 20,
                child: Text(
                  '$count',
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppColors.grey400,        
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );