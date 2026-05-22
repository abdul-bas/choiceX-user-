import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';


Widget buildActionButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(                                            
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,                        
        border: Border.all(color: AppColors.grey200),          
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,                     
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.brand, size: 16),        
          const SizedBox(width: 6),
          TextInter(
            text: label,
            color: AppColors.brand,                            
            letterSpacing: 0.5,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}
