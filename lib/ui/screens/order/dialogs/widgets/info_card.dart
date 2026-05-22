import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:flutter/material.dart';

  Widget buildInfoCard(StatusConfig cfg, bool isRejected) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cfg.color.withValues(alpha: 0.06),       
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: cfg.color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: cfg.color.withValues(alpha: 0.12),  
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(cfg.infoIcon, color: cfg.color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              cfg.infoText,
              style: TextStyle(
                fontSize: 11.5,
                color: isRejected
                    ? AppColors.dangerMid                
                    : AppColors.textNavy.withValues(alpha: 0.6), 
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }