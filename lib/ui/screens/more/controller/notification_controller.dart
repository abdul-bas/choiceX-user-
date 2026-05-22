import 'package:coice/data/models/notification_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/repository/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationController {
  NotificationController._();

  static Stream<dynamic> getNotificationsStream() =>
      NotificationRepository().getNotifications();

  static String getCurrentUserId() => AuthRepository().getUeserId();

  static NotificationModel parseNotification(Map<String, dynamic> data) =>
      NotificationModel.fromMap(data);

  static Future<void> markAsRead(String userId, String notificationId) =>
      NotificationRepository().readNotification(userId, notificationId);

  static Future<void> delete(String userId, String notificationId) =>
      NotificationRepository().deleteNotification(userId, notificationId);

  static void goToOrderDetail(BuildContext context, String orderId) {
    Navigator.pushNamed(context, '/order-details', arguments: orderId);
  }
}
