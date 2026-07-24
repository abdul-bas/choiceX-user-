
import 'package:choicex/state/provider/cart_state.dart';
import 'package:choicex/ui/common_widgets/textInter.dart';
import 'package:choicex/ui/screens/order_summery/widgets/product_section/product_card.dart';
import 'package:flutter/material.dart';

Widget buildProductsSection(BuildContext context, CartState cartState) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextInter(
        text: 'Order Items',
        letterSpacing: 0.5,
        fontWeight: FontWeight.w900,
        fontSize: 16,
      ),
      const SizedBox(height: 12),
      ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cartState.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 5),
        itemBuilder: (context, index) =>
            buildProductSummeryCard(cart: cartState.items[index]),
      ),
    ],
  );
}