import 'dart:convert';
import 'package:coice/state/provider/cart_state.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';
import 'package:coice/ui/screens/cart/widget/cart_body/cart_card.dart';
import 'package:coice/ui/screens/cart/widget/cart_footer/cart_footer.dart';
import 'package:coice/ui/screens/cart/widget/cart_header/cart_header.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:coice/ui/screens/cart/widget/empty_cart/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';



class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CartController.getUserData(),      
      builder: (context, userSnapshot) {
        final result = handleSnapshot(userSnapshot);
        if (result != null) return result;

        return StreamBuilder(
          stream: CartController.getCartStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return buildEmptyCart(context);
            }

            final carts = CartController.parseCarts(snapshot.data);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<CartState>().setCartItems(carts);
            });

            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: buildCartHeader(context),
              body: ListView.builder(
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  final item = carts[index];
                  return CartCardWidget(
                    cart: item,
                    bytes: base64Decode(item.image),
                  );
                },
              ),
              bottomNavigationBar: buildCartFooter(context),
            );
          },
        );
      },
    );
  }

 

 

}






