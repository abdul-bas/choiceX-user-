import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:flutter/material.dart';

Widget buildJourneyTimeline(StatusConfig cfg) {
  const steps = ['Pending', 'Under Review', 'Approved', 'Refunded'];
  final activeIndex =
      steps.indexWhere((s) => s.toLowerCase() == cfg.statusKey.toLowerCase());

  return Row(
    children: List.generate(steps.length * 2 - 1, (i) {
      if (i.isOdd) {
        final isPast = (i ~/ 2) < activeIndex;
        return Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: isPast
                  ? LinearGradient(
                      colors: [cfg.color.withValues(alpha: 0.5), cfg.color])
                  : null,
              color: isPast ? null : AppColors.grey300,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      }

      final stepIndex = i ~/ 2;
      final isActive = stepIndex == activeIndex;
      final isPast = stepIndex < activeIndex;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isActive ? 30 : 22,
            height: isActive ? 30 : 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? cfg.color
                  : isPast
                      ? cfg.color.withValues(alpha: 0.25)
                      : AppColors.timelineInactive,
              border: Border.all(
                color: isActive
                    ? cfg.color
                    : isPast
                        ? cfg.color.withValues(alpha: 0.5)
                        : AppColors.timelineBorder,
                width: isActive ? 0 : 1.5,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: cfg.color.withValues(alpha: 0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: (isPast || isActive)
                  ? Icon(Icons.check_rounded,
                      color: AppColors.white, size: isActive ? 16 : 12)
                  : null,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            steps[stepIndex],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 8.5,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? cfg.color
                  : isPast
                      ? AppColors.timelinePastLabel
                      : AppColors.timelineFutureLabel,
              letterSpacing: 0.2,
            ),
          ),
        ],
      );
    }),
  );
}
