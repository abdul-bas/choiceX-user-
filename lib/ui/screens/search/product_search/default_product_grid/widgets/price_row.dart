 import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/utils/helpers/common/get_discout_price.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

Widget buildDefaultProductGridPriceRow({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
    required double discountedPrice,
    required bool hasDiscount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasDiscount)
                Text(
                  'Rs. ${product.variants[variantIndex]['price']}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 9.5,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              Text(
                'Rs. ${discountedPrice.toInt()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
           onTap: () {
          final variant = product.variants[variantIndex];
          context.read<AuthBloc>().add(AddCart(
              cart: CartModel(
                 category: product.category,
                model: product.model,
               deliveryDate: DateTime.now().add(
  Duration(days: product.expectedDeliveryDays),
),
brand: product.brand,
color: variant['color'],discount: double.parse(variant['price']),

                  variantIndex: variantIndex,
                    discountPrice:  getDiscountPrice(double.parse(variant['price']), double.parse(variant['discount'])),
                  cartId: const Uuid().v4(),
                  productId: product.id,
                  productName: product.productName,
                  image: variant['images'][0],
                  price: double.parse(variant['price']),
                  quantity: 1,
                  userId: AuthRepository().getUeserId(),
                  sellerId: product.sellerId,
                  status: "status")));
        },
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.20),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.add_shopping_cart_rounded,
              color: barndColor,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }