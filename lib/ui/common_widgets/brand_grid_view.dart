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
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';


class BrandGridView
 extends StatelessWidget {
  const BrandGridView
  ({
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GridView.builder(
        shrinkWrap: true,
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: allVariant.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          final item = allVariant[index];
          final variantIndex = item['variantIndex'];
          final ProductModel product = findProduct(item: item, products: products);
          final Uint8List bytes =
              base64Decode(product.variants[variantIndex]['images'][0]);
          final discountedPrice = afterProductDiscount(
            discount: product.variants[variantIndex]['discount'],
            price: product.variants[variantIndex]['price'],
          );

          final bool hasDiscount =
              int.parse(product.variants[variantIndex]['discount']) > 0;
          final int discountPercent =
              int.parse(product.variants[variantIndex]['discount']);

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: SizedBox(
                      height: 170,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                         
                          Image.memory(
                            bytes,
                            fit: BoxFit.cover,
                          ),
                        
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.3, 0.65, 1.0],
                                colors: [
                                  Colors.black.withOpacity(0.28),
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.52),
                                ],
                              ),
                            ),
                          ),
                          
                          if (hasDiscount)
                            Positioned(
                              top: 11,
                              left: 11,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.local_offer_rounded,
                                      size: 9,
                                      color: Color(0xFFE53935),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      '$discountPercent% OFF',
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFE53935),
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                         
                          Positioned(
                            bottom: 10,
                            left: 12,
                            right: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.brand.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 2.2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                               
                                if (index % 5 == 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00C07F),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'NEW',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

               
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          Text(
                            product.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF171717),
                              height: 1.35,
                              letterSpacing: 0.05,
                            ),
                          ),
                          const Spacer(),
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Rs.${discountedPrice.toInt()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF171717),
                                  letterSpacing: -0.6,
                                  height: 1,
                                ),
                              ),
                              if (hasDiscount) ...[
                                const SizedBox(width: 6),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                    'Rs.${product.variants[variantIndex]['price']}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFBBBBBB),
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Color(0xFFBBBBBB),
                                      height: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 10),
                        
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
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: barndColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const AuthBlocListenerWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}