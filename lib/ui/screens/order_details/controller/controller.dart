// order_detail/order_detail_logic.dart

import 'package:coice/core/constants/enums/order_status.dart';
import 'package:coice/core/utils/helpers/date_formate.dart';
import 'package:coice/core/utils/helpers/order/get_status_message.dart';
import 'package:coice/data/models/order_model.dart';


abstract class OrderDetailLogic {
  
  static bool isDelivered(OrderModel order) =>
      order.itemStatus == 'Delivered';

  static bool isCancelledState(OrderModel order, bool isCancelled) =>
      isCancelled || order.cancellationReason != null;

  static bool isArrivingToday(String expectedDeliveryDate, String today) =>
      expectedDeliveryDate == today;

  static bool isOverdue(DateTime currentDay, DateTime expectedDate) =>
      currentDay.isAfter(expectedDate);

  
  static bool canReturn(OrderModel order, DateTime showRefundDay) =>
      order.itemStatus.toLowerCase() == 'delivered' &&
      order.expectedDate.isAfter(showRefundDay);

  
  static String expectedDeliveryDate(OrderModel order) =>
      dateFormate(order.expectedDate);

  static String today() => dateFormate(DateTime.now());

  static DateTime refundCutoffDay() =>
      DateTime.now().subtract(const Duration(days: 2));

  
  static bool isActiveStatus(OrderStatus status, String itemStatus) =>
      status.name == getStatusMessage(itemStatus).toLowerCase();
}