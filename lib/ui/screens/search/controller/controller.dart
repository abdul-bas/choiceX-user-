import 'dart:convert';
import 'dart:typed_data';

import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';

class SearchLogic {
  static ProductModel getProduct({
    required List<ProductModel> products,
    required Map<String, dynamic> item,
  }) {
    return products.firstWhere(
      (e) => e.id == item['productId'],
    );
  }

  static int getVariantIndex(
    Map<String, dynamic> activity,
  ) {
    return int.parse(
      activity['variantIndex'],
    );
  }

  static Uint8List decodeImage(
    ProductModel product,
    int variantIndex,
  ) {
    return base64Decode(
      product.variants[variantIndex]['images'][0],
    );
  }

  static double getDiscountedPrice({
    required ProductModel product,
    required int variantIndex,
  }) {
    return afterProductDiscount(
      discount: product.variants[variantIndex]['discount'],
      price: product.variants[variantIndex]['price'],
    );
  }

  static int getDiscount({
    required ProductModel product,
    required int variantIndex,
  }) {
    return int.parse(
      product.variants[variantIndex]['discount'],
    );
  }

  static bool hasDiscount(int discount) {
    return discount > 0;
  }
    

  static Uint8List getImageBytes({
    required ProductModel product,
    required int variantIndex,
  }) {
    return base64Decode(
      product.variants[variantIndex]['images'][0],
    );
  }

  
  static void navigateToDetails(
    BuildContext context,
    ProductModel product,
    int variantIndex,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(
          product: product,
          variantIndex: variantIndex,
        ),
      ),
    );
  }
}