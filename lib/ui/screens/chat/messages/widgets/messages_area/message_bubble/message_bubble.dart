
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_bubble/bubble_content.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/message_timestamp/message_timestamp.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.c,
    required this.isSelected,
    required this.message,
    required this.isSender,
    required this.index,
  });

  final ChatMessageModel message;
  final bool isSender;
  final int index;
  final ChatProvider c;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.55,
          minWidth: 60,
        ),
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isSender ? 60 : 0,
          right: isSender ? 0 : 60,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: isSender
                    ? AppColors.grey100               
                    : AppColors.chatBubbleReceiverAlt,  
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:
                      Radius.circular(isSender ? 16 : 3),
                  bottomRight:
                      Radius.circular(isSender ? 3 : 16),
                ),
                border: isSender
                    ? null
                    : Border.all(
                        color: AppColors.white, width: 1), 
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: BubbleContent(
                  message: message,
                  isSender: isSender,
                  isSelected: isSelected,
                  c: c,
                  index: index,
                ),
              ),
            ),
            const SizedBox(height: 3),
            MessageTimestamp(
              time: message.createdAt,
              isSender: isSender,
              isRead: message.isRead,
            ),
          ],
        ),
      ),
    );
  }
}