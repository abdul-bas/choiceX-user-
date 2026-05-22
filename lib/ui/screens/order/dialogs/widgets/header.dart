import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:flutter/material.dart';

Widget buildStatusDialogHeroHeader(StatusConfig cfg, String status) {
  return Container(
    height: 148,
    width: double.infinity,
    color: cfg.color,
    child: Stack(
      children: [
        Center(
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white38, width: 1.5),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceWhite,
              border: Border.all(
                  color: cfg.color.withValues(alpha: 0.3), width: 1.5),
            ),
            child: Icon(cfg.icon, color: cfg.color, size: 32),
          ),
        ),
        Positioned(
          top: 14,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration:
                      BoxDecoration(color: cfg.color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: cfg.color,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
