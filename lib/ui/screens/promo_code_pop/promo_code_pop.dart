
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/state/provider/promo_code_pop_state.dart';
import 'package:coice/ui/screens/promo_code_pop/widget/bill_deatil_section.dart';
import 'package:coice/ui/screens/promo_code_pop/widget/promo_code_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class PromoCodePop extends StatelessWidget {
  PromoCodePop({super.key, required this.address});

  final TextEditingController promoCodeController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final String address;

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartState>();
    final promoCodeState = context.watch<PromoCodePopState>();
    final formattedSubtotal = cartState.subTotal;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.grey100,                     
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 18),
              width: 70,
              height: 4.5,
              decoration: BoxDecoration(
                color: AppColors.promoSheetHandle,   
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 5),
          PromoCodeInput(
            promoCodeController: promoCodeController,
            promoCodeState: promoCodeState,
            cartState: cartState,
          ),
          const SizedBox(height: 16),
          BillDetailsSection(
            cartState: cartState,
            promoCodeState: promoCodeState,
            isLoading: isLoading,
            formattedSubtotal: formattedSubtotal.toString(),
            address: address,
          ),
        ],
      ),
    );
  }
}