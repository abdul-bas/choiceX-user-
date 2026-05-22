
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildMenuItem({
  required IconData icon,
  required String title,
  String? subtitle,
  required VoidCallback onTap,
}) {
  return Material(
    color: AppColors.transparent,                      
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: AppColors.brandSubtle,             
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 18),
        child: Row(
          children: [
            // Icon badge
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.menuIconGradient1,         
                    AppColors.menuIconGradient2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(icon,
                    color: AppColors.brand,            
                    size: 24),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey900,        
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.grey600,       
                      ),
                    ),
                  ],
                ],
              ),
            ),

          
            Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(
                color: AppColors.grey100,              
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right,
                color: AppColors.grey500,              
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
