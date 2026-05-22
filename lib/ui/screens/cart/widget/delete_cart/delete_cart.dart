
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteCartPage extends StatelessWidget {
  const DeleteCartPage({
    super.key,
    required this.productId,
    required this.variantId,
  });

  final String productId;
  final int variantId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,        
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDialog,   
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
     
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.brandSubtle,     
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceWhite, 
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowBrand, 
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      size: 32,
                      color: AppColors.danger,     
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 13,
                        color: AppColors.danger,   
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Remove from Cart',
                        style: GoogleFonts.dmSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.danger,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: Column(
                children: [
                  Text(
                    'Remove this item?',
                    style: GoogleFonts.dmSans(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary, 
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This item will be removed from your cart.\nYou can always add it back later.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary, 
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 24),

                 
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => CartController.confirmDelete(
                        context: context,
                        productId: productId,
                        variantId: variantId,
                      ), // ← controller
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.danger, 
                        foregroundColor: AppColors.white,  
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_outline_rounded, size: 18),
                          const SizedBox(width: 7),
                          Text(
                            'Yes, Remove Item',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                 
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.brandSubtle, 
                        foregroundColor: AppColors.textSecondary, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Keep in Cart',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}