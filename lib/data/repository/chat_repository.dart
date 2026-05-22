import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/data/repository/auth_repository.dart';

import 'package:coice/state/bloc/chat/chat_states.dart';
import 'package:coice/ui/screens/chat/controller/message_controller.dart';
import 'package:firebase_database/firebase_database.dart' hide Query;
import 'package:firebase_storage/firebase_storage.dart';

class ChatRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<ChatState> sendProductMessage(
      ChatMessageModel message, String userId, String sellerId) async {
    try {
      final chatRef = firestore.collection('chat').doc(message.chatId);

      await chatRef.set({
        'chatId': message.chatId,
        'userId': userId,
        'sellerId': sellerId,
        'lastMessage':ChatController.getMessage(message),
        'lastMessageTime': FieldValue.serverTimestamp(),
        'localTime': DateTime.now(),
        'sellerUnreadCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      await chatRef.collection('messages').add({
        ...message.toMap(),
        'lastMessageTime': FieldValue.serverTimestamp(),
        'localTime': DateTime.now(),
        'isSeen': false,
      });

      return ChatSendSuccess();
    } catch (e) {
      return ChatError(e.toString());
    }
  }
Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getChats() {
  final userId = AuthRepository().getUeserId();

  return firestore.collection('chat').snapshots().map((snapshot) {
    return snapshot.docs
        .where((doc) => doc.data()['userId'] == userId)
        .toList();
  });
}
  // Stream<QuerySnapshot<Map<String, dynamic>>> getChat(String chatId) {
  //   return firestore
  //       .collection('chat')
  //       .doc(chatId)
  //       .collection('messages')
  //       .orderBy('timestamp', descending: true)
  //       .limit(10)
  //       .snapshots();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String chatId, {
    int limit = 20,
    QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) {
    Query<Map<String, dynamic>> query = firestore
        .collection('chat')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots();
  }

  Future<ChatState> markAsRead(String chatId) async {
    try {
      await firestore.collection('chat').doc(chatId).set({
        'userUnreadCount': 0,
      }, SetOptions(merge: true));

      return ChatMarkedAsRead(chatId);
    } catch (e) {
      return ChatError(e.toString());
    }
  }

  Future<void> deleteChat(String chatId) async {
    await firestore.collection('chat').doc(chatId).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(
      String sellerId) async {
    return await firestore.collection('user').doc(sellerId).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getSingleProduct(
      String productId) {
    return firestore.collection('product').doc(productId).snapshots();
  }

  Future<String> uploadFile(String path) async {
    final file = File(path);

    final ref = storage
        .ref()
        .child('chat_audio/${DateTime.now().millisecondsSinceEpoch}.m4a');

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  Stream<bool> listenUserOnlineStatus(String uid) {
    final ref = FirebaseDatabase.instance.ref('status/$uid/online');

    return ref.onValue.map((event) {
      if (!event.snapshot.exists) return false;

      final value = event.snapshot.value;
      print('dkkdjkdk  $value');
      return value == true;
    });
  }
}
