import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CancelledSection extends StatelessWidget {
  const CancelledSection({super.key, required this.items});

  final OrderModel items;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.dangerLight,    
            child: const Icon(
              Icons.cancel_outlined,
              color: AppColors.dangerMid,              
              size: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Order Cancelled',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.dangerText,              
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'This order has been cancelled',
            style: GoogleFonts.urbanist(
              fontSize: 12,
              color: AppColors.black54,              
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 14),
          Container(
            width: 280,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.successLight,           
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.successBorder,       
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.savings_outlined,
                  size: 15,
                  color: AppColors.successIcon,        
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Refund will be processed within 5–7 business days',
                    style: GoogleFonts.urbanist(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.successText,   
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}