import 'dart:convert';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class OrderProductTile extends StatelessWidget {
  const OrderProductTile({
    super.key,
    required this.items,
    this.complete,
  });

  final OrderModel items;
  final String? complete;

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(items.images);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey300),    
        color: AppColors.surfaceWhite,                  
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: AppColors.grey200,              
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: MemoryImage(bytes),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,          
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Model : ${items.model}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.grey600,        
                      ),
                    ),
                    const SizedBox(height: 8),

                   
                    Row(
                      children: [
                        const Text(
                          'Color : ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grey600,    
                          ),
                        ),
                        Text(
                          items.color,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,       
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
   Row(
                      children: [
                        const Text(
                          'Qty : ',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grey600,  
                          ),
                        ),
                        Text(
                          '${items.quantity}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,      
                          ),
                        ),
                        const Spacer(),
                        Text(
                          getFormattedAmount(items.amount),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,      
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          
          Row(
            children: [
              Expanded(
                child: AuthButton(
                  width: double.infinity,
                  text: 'Detail',
                  function: () => OrderController.goToOrderDetail( 
                      context, items),
                  borderColor: AppColors.brand.withValues(alpha: 0.3), 
                  color: AppColors.transparent,                    
                  hight: 45,
                  textFont: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AuthButton(
                  function: () => OrderController.goToOrderTracking( 
                      context, items),
                  width: double.infinity,
                  text: complete ?? 'Tracking',
                  hight: 45,
                  textColor: AppColors.white,                      
                  textFont: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.brand.withValues(alpha: 0.7),  
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}