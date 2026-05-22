import 'package:coice/state/provider/address_state.dart';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/ui/screens/order/listeners/place_order.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_section.dart';
import 'package:coice/ui/screens/order_summery/widgets/product_section/production_section.dart';
import 'package:coice/ui/common_widgets/checkout_circle_widget.dart';
import 'package:coice/ui/screens/order_summery/widgets/check_out_button/check_out_%20button.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderSummeryScreen extends StatefulWidget {
  const OrderSummeryScreen({super.key});

  @override
  State<OrderSummeryScreen> createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {
  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartState>();

    return Scaffold(
      appBar: AppBar(
        title: TextSlab(
          text: 'CONFIRM ORDER',
          fontSize: 20,
          letterSpacing: 0.3,
        ),
        centerTitle: true,
      ),
      body: placeOrderListener(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CheckoutCircleWidget(
                        addressCompleeted: true,
                        summrySelcted: true,
                      ),
                      const SizedBox(height: 30),
                      Consumer<AddressProvider>(
                        builder: (context, value, child) =>
                            buildAddressSection(context, value),
                      ),
                      const SizedBox(height: 20),
                      buildProductsSection(context, cartState),
                    ],
                  ),
                ),
              ),
              const CheckOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}

