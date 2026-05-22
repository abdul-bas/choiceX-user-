
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/order_summery/controller/controller.dart';
import 'package:flutter/material.dart';

Widget buildAddressSheetHeader(BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
    decoration: BoxDecoration(
      color: AppColors.surfaceWhite,                       
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(28)),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowFainter,                     
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
       
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.grey200,                        
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 25),

        Row(
          children: [
        
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.brandSubtle,               
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.location_on,
                color: AppColors.brand,                       
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

      
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver To',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.addressHeading,       
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Choose your delivery address',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.addressSubtext,           
                  ),
                ),
              ],
            ),
            const Spacer(),

         
            TextButton.icon(
              onPressed: () => OrderSummaryController.goToAddAddress(
                context: context,
                onSuccess: () => Navigator.pop(context),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.brand,            
                backgroundColor: AppColors.brandSubtle,       
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}