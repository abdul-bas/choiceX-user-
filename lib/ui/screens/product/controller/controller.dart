

import 'package:coice/core/routes/push_function.dart';
import 'package:coice/core/utils/helpers/common/get_discout_price.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/notification_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/state/bloc/notification/notification_bloc.dart';
import 'package:coice/state/bloc/notification/notification_event.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/screens/chat/messages/message_screen.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class ProductController {
  ProductController._();

  

  static Future<List<dynamic>> readReviews({
    required String productId,
    required int variantIndex,
  }) =>
      AuthRepository().readReview(
          productId: productId, variantIndex: variantIndex);

  static Stream<dynamic> getUserStream() => AuthRepository().userData();

 

  static void addToCart({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
    required int quantity,
  }) {
    final variant = product.variants[variantIndex];
    final userId = AuthRepository().getUeserId();

    context.read<AuthBloc>().add(
          AddCart(
            cart: CartModel(
              category: product.category,
              model: product.model,
              deliveryDate: DateTime.now()
                  .add(Duration(days: product.expectedDeliveryDays)),
              brand: product.brand,
              color: variant['color'],
              discount: double.parse(variant['price']),
              variantIndex: variantIndex,
              discountPrice: getDiscountPrice(
                double.parse(variant['price']),
                double.parse(variant['discount']),
              ),
              cartId: const Uuid().v4(),
              productId: product.id,
              productName: product.productName,
              image: variant['images'][0],
              price: double.parse(variant['price']),
              quantity: quantity,
              userId: userId,
              sellerId: product.sellerId,
              status: 'status',
            ),
          ),
        );

  
    context.read<NotificationBloc>().add(
          AddNotification(
            notification: NotificationModel(
              title: 'Added to Cart',
              body: 'The item has been added to your cart successfully.',
              type: 'cart',
              orderId: null,
              isRead: false,
              createdAt: DateTime.now(),
            ),
          ),
        );
  }

  
  static void toggleFavourite({
    required BuildContext context,
    required AuthBloc authBloc,
    required String productId,
    required int variantIndex,
    required bool currentValue,
  }) {
    authBloc.add(
      MakeandRmoveFavorite(
        id: productId,
        variantIndex: variantIndex,
        value: !currentValue,
      ),
    );
  }

  

  static void goToProductDetail({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(
          product: product,
          variantIndex: variantIndex,
        ),
      ),
    );
  }

  static void goToCart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MyCartPage()),
    );
  }

  static void goToChat({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
  }) {
    final userId = AuthRepository().getUeserId();
    final chatId = '${userId}_${product.sellerId}';
    pushScreen(
      context,
      ChatScreen(
        product: product,
        sellerId: product.sellerId,
        chatId: chatId,
        variantIndex: variantIndex,
      ),
    );
  }

  
static List<Map<String, dynamic>> convertReviews(dynamic data) {
  return (data as List<dynamic>? ?? [])
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}
 
  static String formatRating(double rating, int totalReviews) {
    if (totalReviews == 0) return '—';
    return rating.toStringAsFixed(1);
  }

 
  static bool hasReviews(int totalReviews) => totalReviews > 0;
static String expectedDelivery(int days) {
  final deliveryDate = DateTime.now().add(Duration(days: days));

  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  return "${months[deliveryDate.month - 1]}-${deliveryDate.day}";
}
}