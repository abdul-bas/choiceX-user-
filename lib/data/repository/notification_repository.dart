import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/notification_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/notification/notification_state.dart';

class NotificationRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<NotificationState> addNotification(
    NotificationModel notification,
  ) async {
    try {
      final userId = AuthRepository().getUeserId();

      final String notificationId =
          DateTime.now().millisecondsSinceEpoch.toString();

      await firestore
          .collection('notifications')
          .doc(userId)
          .collection('items')
          .doc(notificationId)
          .set(notification.toMap(), SetOptions(merge: true));
      await firestore
          .collection('notifications')
          .doc('count')
          .set({'count': FieldValue.increment(1)}, SetOptions(merge: true));
      final snap =
          await firestore.collection('notifications').doc('count').get();
      print(
          'dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      print(snap.data());
      return NotificationLoaded('Notification added successfully');
    } catch (e) {
      return NotificationError(
        e.toString(),
      );
    }
  }

  Future<void> clearNotificationCount() async {
    await firestore.collection('notifications').doc('count').set({
      'count': 0,
    }, SetOptions(merge: true));
  }

  Stream<int> notificationCountStream() {
    return firestore
        .collection('notifications')
        .doc('count')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) return 0;

      return snapshot.data()?['count'] ?? 0;
    });
  }

  getNotifications() {
    final userId = AuthRepository().getUeserId();

    return firestore
        .collection('notifications')
        .doc(userId)
        .collection('items')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  readNotification(String userId, String notificationId) async {
    return await firestore
        .collection('notifications')
        .doc(userId)
        .collection('items')
        .doc(notificationId)
        .delete();
  }

  deleteNotification(String userId, String notificationId) async {
    return await firestore
        .collection('notifications')
        .doc(userId)
        .collection('items')
        .doc(notificationId)
        .update({'isRead': true});
  }
}
