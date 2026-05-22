import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/remote/stripe_remote_datasource.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/orders_event.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/state/provider/promo_code_pop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> makePayment({
  required BuildContext context,
  required ValueNotifier<bool> isLoading,
  required String total,
}) async {
  final orderState = context.read<PromoCodePopState>();
  final List<OrderModel> orders = orderState.getItems;

  if (orders.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Your cart is empty")),
    );
    return;
  }

  isLoading.value = true;

  try {
    final int amount = int.parse(total);
    if (amount <= 0) throw Exception("Invalid amount");

    final paymentIntent = await createPaymentIntent(amount.toString(), 'inr');

    if (paymentIntent['client_secret'] == null) {
      throw Exception("PaymentIntent failed");
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent['client_secret'],
        merchantDisplayName: 'Ikay',
        style: ThemeMode.light,
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    if (!context.mounted) return;

    final List<OrderModel> fixedOrders =
        orders.map((e) => e.copyWith(paymentId: paymentIntent['id'])).toList();

    context.read<AuthBloc>().add(PlaceOrderEvent(order: fixedOrders));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful!")),
    );
    
    final state = context.read<CartState>();
    state.authRepository.clearCart();
    state.clearAll();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Payment Failed: ${e.toString()}"),
      ),
    );
  } finally {
    isLoading.value = false;
  }
}
