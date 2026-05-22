import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/utils/helpers/get_all_variants.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/common_widgets/all_product_variant_grid.dart';
import 'package:flutter/material.dart';

class ProductBrowseGrid extends StatelessWidget {
  const ProductBrowseGrid({
    super.key,
    required this.products,
    required this.text,
  });

  final List<ProductModel> products;
  final String text;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> allVariants = getAllVariant(products);
if (products.isEmpty) {
  return Scaffold(
    backgroundColor: const Color(0xFFF5F6FA),
    appBar: AppBar(
      backgroundColor:  Colors.white,
      elevation:        0,
      surfaceTintColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
         
          color: Color(0xFF0F1320),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
            height: 1, color: const Color(0xFFEEF0F6)),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color:  barndColor.withValues(alpha: 0.08),
              shape:  BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size:  36,
              color: barndColor.withValues(alpha: 0.45),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No $text Found',
            style: const TextStyle(
              color:      Color(0xFF0F1320),
              fontSize:   17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
           Text(
            'Check back later for $text',
            style: TextStyle(
              color:    Color(0xFF9CA3AF),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color:        barndColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:      barndColor.withValues(alpha: 0.28),
                    blurRadius: 12,
                    offset:     const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Go Back',
                    style: TextStyle(
                      color:      Colors.white,
                      fontSize:   14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Color(0xFF0F1320)),
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF0F1320),
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MyCartPage()),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: const Color(0xFFEEF0F6),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: AllProductVariantGrid(
          allVariant: allVariants,
          products: products,
        )));
  }
}
