import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/data/models/chat/chat_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/ui/screens/chat/messages/message_screen.dart';
import 'package:flutter/material.dart';

class ChatController {
  ChatController._();

  static String getCurrentUserId() => AuthRepository().getUeserId();

  static Stream<dynamic> getChatsStream() => ChatRepository().getChats();

  static List<ChatModel> parseChats(dynamic snapshot, String userId) {
    return (snapshot as List)
        .map((d) => ChatModel.fromMap(d.data()))
        .where((c) => c.userId == userId)
        .toList();
  }

  static void goToChat({
    required BuildContext context,
    required ChatModel chat,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          sellerId: chat.sellerId,
          chatId: chat.chatId,
        ),
      ),
    );
  }
 static  String getMessage(ChatMessageModel chat) {
  if (chat.text != null && chat.text!.trim().isNotEmpty) {
    return chat.text!;
  } else if (chat.imageUrl != null && chat.imageUrl!.isNotEmpty) {
    return '📷 Image';
  } else if (chat.audioUrl != null && chat.audioUrl!.isNotEmpty) {
    return '🎤 Audio';
  } else if (chat.productId != null && chat.productId!.isNotEmpty) {
    return '🛒 Product';
  }

  return 'No message';
}
}
