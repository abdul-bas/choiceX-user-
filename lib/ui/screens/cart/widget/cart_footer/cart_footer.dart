import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/ui/common_widgets/custom_text_icon_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

  Widget buildCartFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 10,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,          
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,     
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
           Expanded(
      child: Consumer<CartState>(
        builder: (context, cartState, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextInter(text: 'Sub Total', color: AppColors.textMuted),
              TextInter(
                text: CartController.formatPrice(cartState.subTotal),
                fontSize: 18,
              ),
            ],
          );
        },
      ),
    ),
       Expanded(
      flex: 2,
      child: SizedBox(
        height: 50,
        child: CustomTextIconButton(
          function: () => CartController.proceedToCheckout(context), 
        ),
      ),
    )
        ],
      ),
    );
  }

  
  
