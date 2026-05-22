import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';
import 'package:flutter/material.dart';

  Widget buildEmptyCart(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: AppColors.textMuted,          
            ),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "You haven't added any items yet",
              style: TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => CartController.goToDashboard(context), 
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brand,   
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Go Back',
                style: TextStyle(
                  color: AppColors.white,         
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }