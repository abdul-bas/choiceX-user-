import 'package:cloud_firestore/cloud_firestore.dart';



class ChatModel {
  final String chatId;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String sellerId;
  final int sellerUnreadCount;
  final String userId;
  final int userUnreadCount; 

  ChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.sellerId,
    required this.sellerUnreadCount,
    required this.userId,
    required this.userUnreadCount, 
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    final time = map['lastMessageTime'];

    DateTime parsedTime;

    if (time is Timestamp) {
      parsedTime = time.toDate();
    } else if (time is DateTime) {
      parsedTime = time;
    } else {
      parsedTime = DateTime.now();
    }

    return ChatModel(
      chatId: map['chatId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime: parsedTime,
      sellerId: map['sellerId'] ?? '',
      sellerUnreadCount: map['sellerUnreadCount'] ?? 0,
      userId: map['userId'] ?? '',
      userUnreadCount: map['userUnreadCount'] ?? 0, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'lastMessage': lastMessage,
      'lastMessageTime': Timestamp.fromDate(lastMessageTime),
      'sellerId': sellerId,
      'sellerUnreadCount': sellerUnreadCount,
      'userId': userId,
      'userUnreadCount': userUnreadCount, 
    };
  }
}