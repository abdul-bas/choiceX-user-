
import 'package:choicex/core/constants/app_colors/app_colors.dart';
import 'package:choicex/data/models/order_model.dart';
import 'package:choicex/ui/screens/order_tracking/widgets/app_bar/app_bar.dart';
import 'package:choicex/ui/screens/order_tracking/widgets/delivery_info/delivery_info_card.dart';
import 'package:choicex/ui/screens/order_tracking/widgets/time_line/time_line.dart';
import 'package:flutter/material.dart';


class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,     
      appBar: TrackingAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DeliveryInfoCard(order: order),
            TrackingTimeline(order: order),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}