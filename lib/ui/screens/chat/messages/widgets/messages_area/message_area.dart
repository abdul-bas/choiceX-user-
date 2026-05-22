
  
import 'dart:convert';

import 'package:coice/core/utils/handlers/chat_strem_handler.dart';
import 'package:coice/core/utils/parsers/to_chat_model.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/controller/message_controller.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/date_separator/date_separator.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/empty_state/empty_state.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/image_preview.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_bubble/message_bubble.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_items/date_label.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_items/message_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget messagesArea(
  BuildContext context,
  String chatId,
  ScrollController? scrollController,
) {
  return StreamBuilder(
    stream: ChatRepository().getMessages(chatId),    
    builder: (context, snapshot) {
      final result = chatStreamHandler(snapshot);
      if (result != null) return Center(child: result);

      final data = snapshot.data!.docs;
      if (data.isEmpty) return messageEmptyState();

      final messages = toChatModel(data);
      final currentUser = ChatController.getCurrentUserId();

      return Consumer<ChatProvider>(
        builder: (context, value, child) {
         
          final items = buildMessageItems(messages);

          return Stack(
            children: [
              ListView.builder(
                controller: scrollController,
                reverse: true,
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  final item = items[items.length - 1 - i];

                  if (item is DateLabel) {
                    return DateSeparator(label: item.label);
                  }

                  final msg = item as ChatMessageModel;
                  final isMe = msg.senderId == currentUser;

                  return Align(
                    alignment: isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: MessageBubble(
                        c: value,
                        index: i,
                        isSelected: false,
                        isSender: isMe,
                        message: msg,
                      ),
                    ),
                  );
                },
              ),
              if (value.fileUpload != null)
                Positioned(
                  bottom: 8,
                  left: 12,
                  right: 12,
                  child: ImagePreview(
                    bytes: base64Decode(value.fileUpload!),
                    onRemove: value.removeFile,
                  ),
                ),
            ],
          );
        },
      );
    },
  );
}