import 'package:coice/data/models/notification_model.dart';

abstract class NotificationEvent {}

class AddNotification extends NotificationEvent {
  final NotificationModel notification;
  AddNotification({required this.notification});
}
class MarkNotificationAsRead extends NotificationEvent {
  final bool value;

  MarkNotificationAsRead(this.value);
}
