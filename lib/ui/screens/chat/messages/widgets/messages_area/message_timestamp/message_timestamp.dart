
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class MessageTimestamp extends StatelessWidget {
  const MessageTimestamp({
    super.key,
    required this.time,
    required this.isSender,
    required this.isRead,
  });

  final DateTime time;
  final bool isSender;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    final h = time.hour > 12
        ? time.hour - 12
        : (time.hour == 0 ? 12 : time.hour);
    final m = time.minute.toString().padLeft(2, '0');
    final ampm = time.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '$h:$m $ampm';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isSender ? 'You' : 'Customer',
          style: const TextStyle(
              fontSize: 10,
              color: AppColors.chatTimestamp),            
        ),
        const SizedBox(width: 4),
        Container(
          width: 2,
          height: 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.chatTimestamp,             
          ),
        ),
        const SizedBox(width: 4),
        Text(
          timeStr,
          style: const TextStyle(
              fontSize: 10,
              color: AppColors.chatTimestamp),            
        ),
        if (isRead && isSender) ...[
          const SizedBox(width: 4),
          const Icon(Icons.done_all_rounded,
              size: 12, color: AppColors.brand),        
        ],
        if (!isRead && isSender) ...[
          const SizedBox(width: 4),
          const Icon(Icons.done_all_rounded,
              size: 12, color: AppColors.chatTimestamp),  
        ],
      ],
    );
  }
}

