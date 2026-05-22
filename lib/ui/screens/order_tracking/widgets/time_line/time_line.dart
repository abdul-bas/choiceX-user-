import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_tracking/controller/controller.dart';
import 'package:coice/ui/screens/order_tracking/widgets/time_line/time_line_item.dart';
import 'package:flutter/material.dart';

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final trackingEvents = OrderTrackingLogic.getTrackingEvents(order); 

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,              
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.grey200,                  
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,         
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.brandSubtle,    
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.timeline_rounded,
                  color: AppColors.brand,            
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Delivery Updates',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...List.generate(
            trackingEvents.length,
            (index) => TimelineItem(
              event: trackingEvents[index],
              isFirst: index == 0,
              isLast: index == trackingEvents.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}