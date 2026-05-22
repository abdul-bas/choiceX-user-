
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:flutter/material.dart';

AppBar messageAppBar(BuildContext context, dynamic seller) {
  return AppBar(
    backgroundColor: AppColors.surfaceWhite,          
    elevation: 0,
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 18,
          backgroundColor:
              AppColors.brand.withValues(alpha: 0.15),   
          child: Text(
            seller.userName[0].toUpperCase(),
            style: const TextStyle(
              color: AppColors.brand,                
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                seller.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black87,              
                ),
              ),
              StreamBuilder<bool>(
                stream: ChatRepository().listenUserOnlineStatus(
                    seller.uid!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'Checking...',
                      style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted),   
                    );
                  }
                  final isOnline = snapshot.data!;
                  return Text(
                    isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 11,
                      color: isOnline
                          ? AppColors.success          
                          : AppColors.textMuted,          
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        onPressed: () {},
      ),
    ],
  );
}