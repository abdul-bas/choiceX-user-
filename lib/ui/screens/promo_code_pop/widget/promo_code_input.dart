import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/state/provider/promo_code_pop_state.dart';
import 'package:coice/ui/screens/promo_code_pop/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromoCodeInput extends StatelessWidget {
  const PromoCodeInput({
    super.key,
    required this.promoCodeController,
    required this.promoCodeState,
    required this.cartState,
  });

  final TextEditingController promoCodeController;
  final PromoCodePopState promoCodeState;
  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    final isCouponApplied = PromoCodeController.isCouponApplied(
      promoCodeState.promoCodeDiscount.toDouble(),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,                
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCouponApplied
              ? AppColors.promoSuccess              
              : AppColors.promoBorder,               
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowFaint,         
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: promoCodeController,
              textCapitalization: TextCapitalization.characters,
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.promoInputText,   
                letterSpacing: 2,
              ),
              decoration: InputDecoration(
                hintText: 'Enter coupon code',
                hintStyle: GoogleFonts.nunito(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.promoHint,        
                  letterSpacing: 0.3,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Image.asset(
                    'assets/icons/coupon.png',
                    width: 20,
                    color: AppColors.brand,           
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.local_offer_rounded,
                      color: AppColors.brand,         
                      size: 20,
                    ),
                  ),
                ),
                suffixIcon: promoCodeState.isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.brand,   
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () => promoCodeState.applyCoupon(
                          code: promoCodeController.text,
                          cartState: cartState,
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.brand, 
                        ),
                        child: Text(
                          'APPLY',
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w800,
                            fontSize: 13.5,
                            color: AppColors.brand,  
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),

        
          if (isCouponApplied)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 9,
              ),
              decoration: const BoxDecoration(
                color: AppColors.successLight,        
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 15,
                    color: AppColors.promoSuccess,   
                  ),
                  const SizedBox(width: 6),
                  Text(
                    PromoCodeController.couponSavingLabel(
                      promoCodeState.promoCodeDiscount.toDouble(),
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.successText, 
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}