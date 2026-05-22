// order_tracking/order_tracking_logic.dart

import 'package:coice/core/constants/ui_string/time_line_status.dart';
import 'package:coice/core/utils/helpers/date_formate.dart';
import 'package:coice/core/utils/helpers/ui_helper/order_tracking_builder.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/models/tracking_event_model.dart';

abstract class OrderTrackingLogic {
 
  static int getCurrentStatusIndex(OrderModel order) {
    return timeLineStatuses.indexWhere(
      (status) => status.toLowerCase() == order.itemStatus.toLowerCase(),
    );
  }

  static List<TrackingEvent> getTrackingEvents(OrderModel order) {
    final currentIndex = getCurrentStatusIndex(order);
    return buildTrackingEvents(currentIndex);
  }


  static bool isDelivered(OrderModel order) =>
      order.itemStatus.toLowerCase() == 'delivered';

  static String formattedExpectedDate(OrderModel order) =>
      dateFormate(order.expectedDate);
}