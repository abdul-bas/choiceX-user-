import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:flutter/material.dart';

Widget buildChatButton(
    BuildContext context, int value, ProductModel product) {
  return InkWell(                                       
    onTap: () => ProductController.goToChat(             
      context: context,
      product: product,
      variantIndex: value,
    ),
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height: 52,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,                  
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),    
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,            
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline_rounded,
              color: AppColors.brandSubtle,              
              size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Chat with Seller',
              style: TextStyle(
                color: AppColors.grey700,               
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              color: AppColors.black26,                 
              size: 14),
        ],
      ),
    ),
  );
}

