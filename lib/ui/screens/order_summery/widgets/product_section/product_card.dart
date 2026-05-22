import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/ui/screens/order_summery/widgets/product_section/prouct_detail.dart';
import 'package:coice/ui/screens/order_summery/widgets/product_section/prouct_image.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildProductSummeryCard({required CartModel cart}) {
  final Uint8List bytes = base64Decode(cart.image);
  final formattedPrice = getFormattedAmount(cart.totalPrice);

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.surfaceWhite,                           
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.grey200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowFaint,                        
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProductImage(bytes),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInter(
                text: cart.productName,
                letterSpacing: 0.3,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                maxLines: 2,
                overFlow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              buildProductDetail(
                'Qty',
                cart.quantity.toString(),
                Icons.shopping_cart_outlined,
              ),
              const SizedBox(height: 4),
              buildProductDetail(
                'Unit Price',
                '₹${NumberFormat('#,##,###', 'en_IN').format(cart.discountPrice)}',
                Icons.sell_outlined,
              ),
              const SizedBox(height: 4),
              buildProductDetail(
                'Status',
                cart.status,
                Icons.info_outline,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        TextInter(
          text: formattedPrice,
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.brand,                         
        ),
      ],
    ),
  );
}