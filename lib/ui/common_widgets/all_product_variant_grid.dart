import 'dart:convert';
import 'dart:typed_data';

import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/utils/helpers/common/get_discout_price.dart';
import 'package:coice/core/utils/helpers/find_product.dart';
import 'package:coice/data/models/cart_model/cart_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/ui/screens/auth/listeners/auth_bloc_listener.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AllProductVariantGrid extends StatelessWidget {
  const AllProductVariantGrid({
    super.key,
    required this.products,
    required this.allVariant,
    this.physics,
  });

  final List<ProductModel> products;
  final List<Map<String, dynamic>> allVariant;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: allVariant.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = allVariant[index];
          final variantIndex = item['variantIndex'];
          
          final product = findProduct(item: item, products: products);
          final Uint8List bytes =
              base64Decode(product.variants[variantIndex]['images'][0]);
          final discountedPrice = afterProductDiscount(
            discount: product.variants[variantIndex]['discount'],
            price: product.variants[variantIndex]['price'],
          );

          return GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                  product: product,
                  variantIndex: variantIndex,
                ),
              ),
            ),
            child: Container(
              height: 300,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: DecorationImage(
                          image: MemoryImage(bytes),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (int.parse(product.variants[variantIndex]['discount']) > 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TextInter(
                          text:
                              '${product.variants[variantIndex]['discount']}% OFF',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.8),
                                Colors.white.withOpacity(0.95),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextInter(
                                    letterSpacing: 0.3,
                                    text: product.productName,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                    maxLines: 1,
                                  ),
                                  TextInter(
                                    letterSpacing: 0.3,
                                    text: product.brand,
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextInter(
                                        letterSpacing: 0.3,
                                        text:
                                            'Rs. ${discountedPrice.toInt().toString()}',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.deepPurple.shade700,
                                      ),
                                      TextInter(
                                        letterSpacing: 0.3,
                                        text:
                                            'Rs. ${product.variants[variantIndex]['Price']}',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                        undelineColor: Colors.black,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
          final variant = product.variants[variantIndex];
          context.read<AuthBloc>().add(AddCart(
              cart: CartModel(
                category: product.c,
                 model: product.model,
               deliveryDate: DateTime.now().add(
  Duration(days: product.expectedDeliveryDays),
),
brand: product.brand,
color: variant['color'],discount: double.parse(variant['price']),
                  variantIndex: variantIndex,
                  discountPrice: getDiscountPrice(double.parse(variant['price']), double.parse(variant['discount'])),
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
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        color: barndColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const AuthBlocListenerWidget()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

