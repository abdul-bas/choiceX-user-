
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/common/get_discout_price.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

Widget buildFilterVariantPriceRow({
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
                style: const TextStyle(
                  color: AppColors.priceStrike,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            const Text(
              
              '',
            ),
            Text(
              'Rs. ${discountedPrice.toInt()}',
              style: const TextStyle(
                color: AppColors.brand,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
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
                  quantity: 1,
                  userId: AuthRepository().getUeserId(),
                  sellerId: product.sellerId,
                  status: 'status',
                ),
              ));
        },
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.brand,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandShadowStrong,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.add_shopping_cart_rounded,
            color: AppColors.white,
            size: 16,
          ),
        ),
      ),
    ],
  );
}