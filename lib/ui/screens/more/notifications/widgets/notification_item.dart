import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/notification/get_color.dart';
import 'package:coice/core/utils/helpers/notification/get_icon.dart';
import 'package:coice/core/utils/helpers/notification/get_time.dart';
import 'package:coice/ui/screens/more/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildNotificationItem(
  BuildContext context,
  String userId,
  String notificationId,
  Map<String, dynamic> notification,
  
) {
  final message =
      NotificationController.parseNotification(notification);

  return Dismissible(
    key: Key(notificationId),
    direction: DismissDirection.endToStart,
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: AppColors.danger,                         
      child: const Icon(Icons.delete_outline,
          color: AppColors.white),              
    ),
    onDismissed: (_) async {
      await NotificationController.markAsRead(      
          userId, notificationId);
    },
    child: InkWell(
      onTap: () async {
        if (!message.isRead) {
          await NotificationController.delete(        
              userId, notificationId);
        }
        if (message.type == 'order' && message.orderId != null) {
          NotificationController.goToOrderDetail(     
              // ignore: use_build_context_synchronously
              context, notification['orderId']);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: message.isRead
              ? AppColors.surfaceWhite                 
              : AppColors.notificationUnreadBg,      
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              height: 44, width: 44,
              decoration: BoxDecoration(
                color: getNotificationIconColor(message.type)
                    .withValues(alpha:  0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                getNotificationIcon(message.type),
                color: getNotificationIconColor(message.type),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.title,
                    style: GoogleFonts.inter(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    getNotificationTimeAgo(message.createdAt),
                    style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.grey500),     
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}