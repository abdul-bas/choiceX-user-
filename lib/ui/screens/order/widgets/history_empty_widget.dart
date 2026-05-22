
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:flutter/material.dart';

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          
            Container(
              width: 110, height: 110,
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,           
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowDark,          
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.receipt_long_outlined,
                    size: 48,
                    color: AppColors.iconDisabled,        
                  ),
                  Positioned(
                    bottom: 22, right: 20,
                    child: Container(
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.orderHistoryBadge, 
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        size: 12,
                        color: AppColors.white,          
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'No order history',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.orderEmptyHeading,      
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),

            const Text(
              'Your completed and\ncancelled orders will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: AppColors.orderEmptySubtext,     
                height: 1.65,
              ),
            ),
            const SizedBox(height: 28),

           
            TextButton(                                   
              onPressed: () =>
                  OrderController.goToDashboard(context), 
              style: TextButton.styleFrom(
                backgroundColor: AppColors.orderShopBtnBg,     
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: const BorderSide(
                    color: AppColors.orderShopBtnBorder,  
                    width: 1.5,
                  ),
                ),
              ),
              child: const Text(
                'Go to Shop',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.orderShopBtnText,     
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}