import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';

import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';
import 'package:coice/ui/screens/cart/widget/delete_cart/delete_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartCardWidget extends StatelessWidget {
  const CartCardWidget({
    super.key,
    required this.cart,
    required this.bytes,
  });

  final CartModel cart;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartState>(
      builder: (context, cartState, child) {
        
        final discount = CartController.discountLabel(
          cart.price,
          cart.discountPrice,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,      
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,    
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      bytes,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                cart.productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColors.danger, // ← AppColors
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => DeleteCartPage(
                                    productId: cart.productId,
                                    variantId: cart.variantIndex,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        
                        if (discount != null)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.success,   // ← AppColors
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              discount,
                              style: const TextStyle(
                                color: AppColors.white,   // ← AppColors
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  CartController.formatPrice(
                                      cart.price * cart.quantity),
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.textMuted, 
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  CartController.formatPrice(cart.totalPrice),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (cart.savedAmount > 0)
                                  Text(
                                    'You save ${CartController.formatPrice(cart.savedAmount)}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.success,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),

                           
                            Container(
                              height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.surfaceLight,  
                                border: Border.all(
                                    color: AppColors.borderLight), 
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, size: 18),
                                    onPressed: () => CartController.decrement(
                                      productId: cart.productId,
                                      variantIndex: cart.variantIndex,
                                    ), 
                                  ),
                                  Text(
                                    '${cart.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 18),
                                    onPressed: () => CartController.increment(
                                      productId: cart.productId,
                                      variantIndex: cart.variantIndex,
                                    ), // ← controller
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}