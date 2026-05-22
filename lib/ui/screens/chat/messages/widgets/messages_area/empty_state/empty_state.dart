 import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget messageEmptyState() => const Center(
      child: Text(
        'No messages yet.\nStart chatting!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.textMuted,              
            fontSize: 16),
      ),
    );
