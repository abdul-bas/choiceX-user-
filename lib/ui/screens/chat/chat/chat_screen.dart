import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/chat/chat_model.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/ui/screens/chat/chat/widgets/chat_list_item.dart';
import 'package:coice/ui/screens/chat/chat/widgets/empty_state.dart';
import 'package:coice/ui/screens/chat/messages/message_screen.dart';
import 'package:flutter/material.dart';


class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRepository = ChatRepository();

    return StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      stream: chatRepository.getChats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyChatState(
            message: 'No messages yet',
            subtitle: 'Your conversations will appear here',
          );
        }

        final chats = snapshot.data!
            .map((d) => ChatModel.fromMap(d.data()))
            .toList();

        return ListView.separated(
          itemCount: chats.length,
          separatorBuilder: (_, __) => const Divider(
            height: 1,
            color: AppColors.grey200,               
          ),
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ChatListItem(
              chat: chat,
              onTap: () {
                 ChatRepository().markAsRead(chat.chatId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          sellerId: chat.sellerId,
          chatId: chat.chatId,
        ),
      ),
    );
              },
            );
          },
        );
      },
    );
  }
}
