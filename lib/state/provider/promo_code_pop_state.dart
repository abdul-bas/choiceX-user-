import 'package:coice/core/utils/helpers/get_promo_code_discount.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PromoCodePopState extends ChangeNotifier {
  int promoCodeDiscount = 0;
  bool isLoading = false;
  List<OrderModel> orders = [];

  Future<void> applyCoupon({
    required String code,
    required CartState cartState,
  }) async {
    if (code.trim().isEmpty) return;

    isLoading = true;
    notifyListeners();

    promoCodeDiscount = await getPromoCodeDiscount(code, cartState);

    isLoading = false;
    notifyListeners();
  }

  void addOrders(
    CartState cartState,
    String address,
  ) {
    orders.clear();

    final String userId = AuthRepository().getUeserId();
    final DateTime today = DateTime.now();

    for (final entry in cartState.items) {
     
     


      
      // final DateTime expectedDate =
      //     today.add(Duration(days:entry. product.expectedDeliveryDays));
     
    
      final orderModel = OrderModel(
        images: entry.image,
        brand: entry.brand,
        color: entry.color,
       discount:entry.discount,
        model: entry.model,
        
        discountPrice: entry.discountPrice,
        productName: entry.productName,
        paymentId: '',
        orderId: Uuid().v4(),
        userId: userId,
        productId: entry.productId,
        sellerId: entry.sellerId,
        variantIndex: entry.variantIndex,
        quantity: entry.quantity,
      amount:entry.price,
        itemStatus: 'pending',
        paymentStatus: 'paid',
        paymentMethod: 'card',
        paymentAddress: address,
        date: today,
        expectedDate: entry.deliveryDate,
      );

      orders.add(orderModel);
    }

    notifyListeners();
  }

  get getItems {
    return orders;
  }
}
