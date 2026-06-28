
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_time.dart';
import 'package:coice/data/models/chat/chat_model.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.chat,
    required this.onTap,
  });

  final ChatModel chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const CircleAvatar(child: Icon(Icons.store)),
          const SizedBox(width: 12),
      
            
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller ${chat.sellerId.substring(0, 6)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.lastMessage.isEmpty
                      ? 'No messages yet'
                      : chat.lastMessage,
                      
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.grey600,    
                  ),
                ),
              ],
            ),
          ),
      
        
          Column(
            children: [
              Text(
                getFormatTime(chat.lastMessageTime),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey500,    
                ),
              ),
              if (chat.userUnreadCount >= 1)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.danger,     
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    chat.userUnreadCount.toString(),
                    style: const TextStyle(
                      color: AppColors.white,  
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


