
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget productError() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.dangerSubtle),            
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline,
              size: 14, color: AppColors.white),       
          SizedBox(width: 6),
          Text('Product unavailable',
              style: TextStyle(
                  color: AppColors.white,                
                  fontSize: 12)),
        ],
      ),
    );
