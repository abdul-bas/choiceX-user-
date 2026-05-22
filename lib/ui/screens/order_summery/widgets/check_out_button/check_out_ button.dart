import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/order_summery/controller/controller.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.brand), 
            side: const WidgetStatePropertyAll(
              BorderSide(color: AppColors.black),               
            ),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(13)),
              ),
            ),
          ),
          onPressed: () =>
              OrderSummaryController.showCheckout(context),      
          child: TextInter(
            text: 'CHECK OUT',
            letterSpacing: 0.5,
            color: AppColors.white,                             
          ),
        ),
      ),
    );
  }
}

