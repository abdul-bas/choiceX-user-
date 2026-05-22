

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.surfaceOffWhite,    
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,           
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,             
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.bookmark_border_rounded,
        size: 40,
        color: AppColors.brand,                      
      ),
    ),
                SizedBox(height: 20),
                Text(
                  'Nothing saved yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,     
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap the heart on any product\nto save it here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textCaption,  
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

