import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/tracking_event_model.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';


class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.event,
    this.isFirst = false,
    this.isLast = false,
  });

  final TrackingEvent event;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.0,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 44,
        height: 44,
        indicator: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: event.isCurrent
                ? LinearGradient(
                    colors: [
                      AppColors.brand,               
                      AppColors.brand.withValues(alpha: 0.7),
                    ],
                  )
                : null,
            color: event.isCurrent
                ? null
                : event.isCompleted
                    ? AppColors.success            
                    : AppColors.grey300,             
            shape: BoxShape.circle,
            boxShadow: event.isCurrent
                ? [
                    BoxShadow(
                      color: AppColors.shadowBrand, 
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            event.icon,
            color: AppColors.white,                 
            size: event.isCurrent ? 22 : 20,
          ),
        ),
      ),
      beforeLineStyle: LineStyle(
        color: event.isCompleted
            ? AppColors.success                    
            : AppColors.grey300,                   
        thickness: 2.5,
      ),
      endChild: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!event.isCompleted) const SizedBox(height: 30),
            Flexible(
              child: Text(
                event.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: event.isCurrent
                      ? FontWeight.w700
                      : FontWeight.w600,
                  color: event.isCurrent
                      ? AppColors.brand             
                      : event.isCompleted
                          ? AppColors.black87       
                          : AppColors.grey600,       
                  letterSpacing: 0.2,
                ),
              ),
            ),
            if (event.isCompleted) ...[
              const SizedBox(height: 6),
              Text(
                event.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.grey600,          
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}