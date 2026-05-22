
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:coice/ui/screens/more/controller/notification_controller.dart';
import 'package:coice/ui/screens/more/notifications/widgets/empty_state.dart';
import 'package:coice/ui/screens/more/notifications/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {  
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _userId = NotificationController.getCurrentUserId(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceLight,           
      appBar: AppBar(
        backgroundColor: AppColors.surfaceWhite,       
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.black),                  
          onPressed: () => Navigator.pop(context),
        ),
        title: TextSlab(
          text: 'Notifications',
          letterSpacing: 0.3,
          fontSize: 20,
        ),
      ),
      body: StreamBuilder(
        stream: NotificationController.getNotificationsStream(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return buildNotificationEmptyState();
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final doc = notifications[index];
              final data = doc.data() as Map<String, dynamic>;
              return buildNotificationItem(
                context,
                _userId,
                doc.id,
                data,                                   
              );
            },
          );
        },
      ),
    );
  }
}