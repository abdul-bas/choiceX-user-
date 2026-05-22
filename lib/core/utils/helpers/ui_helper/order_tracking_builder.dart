

import 'package:coice/data/models/tracking_event_model.dart';
import 'package:flutter/material.dart';

List<TrackingEvent> buildTrackingEvents(int currentStatusIndex) {
  return   [
  TrackingEvent(
    title: 'Order Placed',
    description: 'We have received your order',
    isCompleted: currentStatusIndex >= 0,
    isCurrent: currentStatusIndex == 0,
    icon: Icons.receipt_long_rounded,
  ),
  TrackingEvent(
    title: 'Order Confirmed',
    description: 'Your order has been confirmed',
    isCompleted: currentStatusIndex >= 1,
    isCurrent: currentStatusIndex == 1,
    icon: Icons.verified_rounded,
  ),
  TrackingEvent(
    title: 'Processing',
    description: 'Your order is being prepared',
    isCompleted: currentStatusIndex >= 2,
    isCurrent: currentStatusIndex == 2,
    icon: Icons.inventory_2_rounded,
  ),
  TrackingEvent(
    title: 'Out for Delivery',
    description: 'Your order is on the way',
    isCompleted: currentStatusIndex >= 3,
    isCurrent: currentStatusIndex == 3,
    icon: Icons.local_shipping_rounded,
  ),
  TrackingEvent(
    title: 'Delivered',
    description: currentStatusIndex >= 4
        ? 'Order delivered successfully'
        : 'Order will be delivered soon',
    isCompleted: currentStatusIndex >= 4,
    isCurrent: currentStatusIndex == 4,
    icon: Icons.check_circle_rounded,
  ),
];

}
