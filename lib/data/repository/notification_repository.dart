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
        .set(notification.toMap());

    return NotificationLoaded('Notification added successfully');
  } catch (e) {
    return NotificationError(e.toString());
  }
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
  readNotification(String userId,String notificationId)async{
 return  await  firestore
            .collection('notifications')
            .doc(userId)
            .collection('items')
            .doc(notificationId)
            .delete();
  }
  deleteNotification(String userId,String notificationId)async{
 return await  firestore
                .collection('notifications')
                .doc(userId)
                .collection('items')
                .doc(notificationId)
                .update({'isRead': true});
  }
}
