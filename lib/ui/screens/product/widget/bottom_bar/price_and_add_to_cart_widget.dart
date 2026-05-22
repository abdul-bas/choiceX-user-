import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceAndAddToCartWidget extends StatelessWidget {
  const PriceAndAddToCartWidget({
    super.key,
    required this.product,
    required this.value,
    required this.quentity,
  });

  final ProductModel product;
  final int value;
  final int quentity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.crimsonPro(
                    color: AppColors.black,            
                    fontSize: 20),
                children: [
                  TextSpan(
                    text: ' Rs. ',
                    style: GoogleFonts.crimsonPro(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  TextSpan(
                    text: afterProductDiscount(
                      discount: product.variants[value]['discount'],
                      price: product.variants[value]['price'],
                    ).toStringAsFixed(0),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.brand), 
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                  ),
                ),
                onPressed: () => ProductController.addToCart( 
                  context: context,
                  product: product,
                  variantIndex: value,
                  quantity: quentity,
                ),
                label: TextInter(
                  text: 'Add to Cart',
                  letterSpacing: 0.5,
                  color: AppColors.white,            
                ),
                icon: const Icon(Icons.shopping_cart,
                    color: AppColors.white),            
              ),
            ),
          ),
        ],
      ),
    );
  }
}