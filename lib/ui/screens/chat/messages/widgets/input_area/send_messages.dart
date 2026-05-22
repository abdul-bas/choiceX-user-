import 'package:coice/data/models/chat/chat_message_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/bloc/chat/chat_bloc.dart';
import 'package:coice/state/bloc/chat/chat_events.dart';
import 'package:coice/ui/screens/chat/controller/message_controller.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void sendMessage(
  BuildContext context,
  dynamic controller,
  ValueNotifier<ProductModel?> product,
  int? variantIndex,
  String chatId,
  String sellerId,
  ValueNotifier<bool> isFocus,
  dynamic scrollController,
  String? audioUrl,
  String? imageUrl,
  bool isSend,
  Function onRemove,
) {
  final text = controller.text.trim();
  final userId = ChatController.getCurrentUserId();    

  if (isSend) {
    context.read<ChatBloc>().add(
          SendProductMessage(
            ChatMessageModel(
              messageId: const Uuid().v4(),
              chatId: chatId,
              senderId: userId,                        
              receiverId: sellerId,
              variantIndex: variantIndex,
              productId: product.value?.id,
              productName: product.value?.productName,
              text: text,
              createdAt: DateTime.now(),
              audioUrl: audioUrl,
              imageUrl: imageUrl,
              isRead: false,
            ),
            userId,                                    
            sellerId,
          ),
        );
    onRemove();
    controller.clear();
    product.value = null;
    isFocus.value = false;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}