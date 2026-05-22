
import 'package:coice/core/utils/helpers/get_formatted_amount.dart';

abstract class PromoCodeController {
 
  static bool isCouponApplied(double promoDiscount) => promoDiscount > 0;

  static String couponSavingLabel(double promoDiscount) =>
      'Coupon applied! You\'re saving ₹${promoDiscount.toInt()}';

  static String formattedPrice(double price) => '₹ ${price.toInt()}';

  static String discountLabel(double amount) =>
      '- ${getFormattedAmount(amount)}';

  static String couponDiscountLabel(double discount) => '- ₹ $discount';
}