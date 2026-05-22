import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String messageId;
  final String chatId;
  final String senderId;
  final String receiverId;

  final String? text;
  final String? imageUrl;
  String? audioUrl;
  final String? productId;
  final String? productName;
  bool isRead;
  final int? variantIndex;
  final DateTime createdAt;

  ChatMessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    this.text,
    this.imageUrl,
    this.audioUrl,
    this.productId,
    this.productName,
    this.variantIndex,
    required this.createdAt,required this.isRead
  });

  Map<String, dynamic> toMap() {
    return {
      'isRead':isRead,
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'productId': productId,
      'productName': productName,
      'variantIndex': variantIndex,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      isRead: map['isRead'],
      messageId: map['messageId'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'],
      imageUrl: map['imageUrl'],
      audioUrl: map['audioUrl'],
      productId: map['productId'],
      productName: map['productName'],
      variantIndex: map['variantIndex'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
