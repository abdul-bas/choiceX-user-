import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/screens/order_summery/order_summery.dart';
import 'package:coice/ui/screens/user_address/add_user_address/add_address.dart';
import 'package:coice/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartController {
  CartController._();

  static void increment({
    required String productId,
    required int variantIndex,
  }) {
    AuthRepository().incrementQuantity(
      productId: productId,
      variantIndex: variantIndex,
    );
  }

  static void decrement({
    required String productId,
    required int variantIndex,
  }) {
    AuthRepository().decrementQuantity(
      productId: productId,
      variantIndex: variantIndex,
    );
  }

  static void confirmDelete({
    required BuildContext context,
    required String productId,
    required int variantId,
  }) {
    context.read<AuthBloc>().add(
          DeleteCart(productId: productId, variantId: variantId),
        );
    Navigator.pop(context);
  }

  static Future<void> proceedToCheckout(BuildContext context) async {
    final hasAddress = await AuthRepository().addressEmptyOrNot();
    if (!context.mounted) return;

    if (hasAddress) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const OrderSummeryScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddAddress(
            isDefault: null,
            navigation: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OrderSummeryScreen()),
              );
            },
          ),
        ),
      );
    }
  }

  static void goToCart(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyCartPage()),
    );
  }

  static void goToDashboard(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen()),
      (route) => false,
    );
  }

  static Future<dynamic> getUserData() => AuthRepository().getUserData();

  static Stream<dynamic> getCartStream() =>
      AuthRepository().getCartItemsStream();

  static List<CartModel> parseCarts(dynamic snapshot) {
    return (snapshot.docs as List)
        .map((doc) => CartModel.fromMap(doc.data()))
        .toList();
  }

  static String? discountLabel(double price, double discountPrice) {
    if (price <= discountPrice) return null;
    final pct = ((1 - discountPrice / price) * 100).toStringAsFixed(0);
    return '$pct% OFF';
  }

  static String formatPrice(double amount) => '₹${amount.toStringAsFixed(2)}';
}
