
import 'dart:convert';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/state/provider/chat_provider.dart';
import 'package:coice/ui/screens/chat/messages/dialog/show_full_image.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/audio_bubble/audio_bubble.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/product_card/product_card.dart';
import 'package:flutter/material.dart';

class BubbleContent extends StatelessWidget {
  const BubbleContent({
    super.key,
    required this.message,
    required this.isSender,
    required this.isSelected,
    required this.c,
    required this.index,
  });

  final ChatMessageModel message;
  final bool isSender;
  final bool isSelected;
  final int index;
  final ChatProvider c;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        message.imageUrl != null && message.imageUrl!.isNotEmpty;
    final hasAudio =
        message.audioUrl != null && message.audioUrl!.isNotEmpty;
    final hasProduct = message.productId != null &&
        message.productId!.isNotEmpty &&
        message.variantIndex != null;
    final hasText =
        message.text != null && message.text!.trim().isNotEmpty;

    final textColor = isSender
        ? AppColors.chatTextSender                      
        : AppColors.chatTextReceiver;                    

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasProduct) ...[
          ProductCard(
            productId: message.productId!,
            variantIndex: message.variantIndex!,
            isSender: isSender,
          ),
          if (hasText || hasImage || hasAudio)
            const SizedBox(height: 8),
        ],
        if (hasAudio) ...[
          AudioBubble(
              path: message.audioUrl!, isSender: isSender),
          if (hasText) const SizedBox(height: 6),
        ],
        if (hasImage) ...[
          GestureDetector(
            onTap: () => showFullImage(context, message.imageUrl!),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                base64Decode(message.imageUrl!),
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (hasText) const SizedBox(height: 6),
        ],
        if (hasText)
          Text(
            message.text!,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              height: 1.45,
            ),
          ),
      ],
    );
  }
}