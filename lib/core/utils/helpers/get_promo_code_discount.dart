import 'package:coice/data/models/coupon_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/provider/cart_state.dart';
Future<int> getPromoCodeDiscount(
  String code,
  CartState cartState,
) async {
  try {
    final doc = await AuthRepository().getCouponCode(code.trim());
    if (doc == null) return 0;

    final coupon =
        CouponModel.fromMap(doc.data() as Map<String, dynamic>);

    if (!coupon.isActive) return 0;

    int totalPromoDiscount = 0;

    final applyType = coupon.applyType.toLowerCase();
    final couponCategories =
        coupon.categories.map((e) => e.toLowerCase()).toList();
    final couponBrands =
        coupon.brands.map((e) => e.toLowerCase()).toList();

   
    for (final cart in cartState.items) {
      final productCategories = cart.category
          .split('&')
          .map((e) => e.trim().toLowerCase())
          .toList();

      final productBrand = cart.brand.toLowerCase();

      bool isApplicable = false;

      if (applyType == 'all') {
        isApplicable = true;
      } else if (applyType == 'category') {
        isApplicable = productCategories.any(
          (cat) => couponCategories.contains(cat),
        );
      } else if (applyType == 'brand') {
        isApplicable = couponBrands.contains(productBrand);
      }

      if (!isApplicable) continue;

      int discount =
          ((cart.discountPrice * cart.quantity) *
                  coupon.discountPercent /
                  100)
              .round();

      if (coupon.maxDiscount > 0 &&
          discount > coupon.maxDiscount) {
        discount = coupon.maxDiscount.toInt();
      }

      totalPromoDiscount += discount;
    }

    print("Valid promo code: $totalPromoDiscount");

    return totalPromoDiscount;
  } catch (e) {
    print("Error getting promo code: $e");
    return 0;
  }
}