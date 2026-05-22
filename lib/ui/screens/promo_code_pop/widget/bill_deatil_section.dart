import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';
import 'package:coice/services/strip_payment.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/state/provider/promo_code_pop_state.dart';
import 'package:coice/ui/screens/promo_code_pop/controller/controller.dart';
import 'package:coice/ui/screens/promo_code_pop/widget/price_row.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class BillDetailsSection extends StatelessWidget {
  const BillDetailsSection({
    super.key,
    required this.cartState,
    required this.promoCodeState,
    required this.isLoading,
    required this.formattedSubtotal,
    required this.address,
  });

  final CartState cartState;
  final PromoCodePopState promoCodeState;
  final ValueNotifier<bool> isLoading;
  final String formattedSubtotal;
  final String address;

  @override
  Widget build(BuildContext context) {
    final isCouponApplied = PromoCodeController.isCouponApplied(
      promoCodeState.promoCodeDiscount.toDouble(),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.promoBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  size: 16,
                  color: AppColors.promoIconMuted,
                ),
                SizedBox(width: 7),
                Text('Bill Details'),
              ],
            ),
          ),
          Container(height: 1, color: AppColors.promoDivider),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartState.items.length,
              itemBuilder: (context, index) {
                final cart = cartState.items[index];
                return CartPriceRow(
                  multiplicationOption: '${cart.quantity} x',
                  formattedSubtotal:
                      PromoCodeController.formattedPrice(cart.price),
                  title: cart.productName,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 1,
              color: AppColors.promoDivider,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Column(
              children: [
                CartPriceRow(
                  title: 'Total',
                  formattedSubtotal: getFormattedAmount(cartState.total),
                ),
                CartPriceRow(
                  title: 'Product Discount',
                  formattedSubtotal: PromoCodeController.discountLabel(
                    cartState.deductedAmount,
                  ),
                  colorShade: AppColors.dangerText,
                  fontSize: 13,
                ),
                if (isCouponApplied)
                  CartPriceRow(
                    fontSize: 13,
                    title: 'Coupon Discount',
                    formattedSubtotal: PromoCodeController.couponDiscountLabel(
                      promoCodeState.promoCodeDiscount.toDouble(),
                    ),
                    colorShade: AppColors.dangerText,
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 6, 10, 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.brandSubtle,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.brandSubtle,
              ),
            ),
            child: Row(
              children: [
                const Text('Sub Total'),
                const Spacer(),
                Text('₹ $formattedSubtotal'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              return AuthButton(
                width: 500,
                text: value ? 'Processing...' : 'Check out',
                textColor: AppColors.white,
                hight: 52,
                function: value
                    ? null
                    : () {
                        promoCodeState.addOrders(cartState, address);
                        makePayment(
                          context: context,
                          total: double.parse(formattedSubtotal)
                              .toInt()
                              .toString(),
                          isLoading: isLoading,
                        );
                      },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
