import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/common/parse_color.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/core/utils/parsers/to_particular_product_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/repository/chat_repository.dart';
import 'package:coice/ui/screens/chat/messages/widgets/messages_area/product_card/proudct_error.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productId,
    required this.variantIndex,
    required this.isSender,
  });

  final String productId;
  final int variantIndex;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          ChatRepository().getSingleProduct(productId),    
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.shadowDark,               
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.textSubdued,         
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data == null) {
          return productError();
        }

        final ProductModel? product =
            toParticularProduct(snapshot);
        if (product == null ||
            product.variants.isEmpty ||
            variantIndex >= product.variants.length) {
          return productError();
        }

        final variant = Map<String, dynamic>.from(
            product.variants[variantIndex]);
        final price =
            double.tryParse(variant['price']?.toString() ?? '') ?? 0;
        final color = variant['color']?.toString() ?? '';
        final qty = variant['quantity']?.toString() ?? '0';

        Uint8List? imageBytes;
        final images = variant['images'];
        if (images is List && images.isNotEmpty) {
          try {
            imageBytes = base64Decode(images.first as String);
          } catch (_) {}
        }

        return Container(
          decoration: BoxDecoration(
            color: isSender
                ? AppColors.white.withValues(alpha: 0.92) 
                : AppColors.chatBubbleReceiver,          
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSender
                  ? AppColors.shadowDark                 
                  : AppColors.white,                      
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageBytes != null)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
                  child: Image.memory(imageBytes,
                      height: 120, fit: BoxFit.cover),
                )
              else
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: isSender
                        ? AppColors.grey200            
                        : AppColors.iconDark,            
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        color: AppColors.chatTimestamp,  
                        size: 30),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSender
                            ? AppColors.chatTextSender  
                            : AppColors.chatTextReceiverAlt, 
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (color.isNotEmpty) ...[
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: parseColor(color),
                              border: Border.all(
                                  color: AppColors.shadowDark), 
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            color,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSender
                                  ? AppColors.black54   
                                  : AppColors.textSubdued,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Text(
                          'Qty: $qty',
                          style: TextStyle(
                            fontSize: 11,
                            color: isSender
                                ? AppColors.black54      
                                : AppColors.textSubdued, 
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      getFormattedAmount(price),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSender
                            ? AppColors.chatTextSender   
                            : AppColors.chatTextReceiverAlt,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
