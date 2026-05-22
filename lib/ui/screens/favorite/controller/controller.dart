import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/core/utils/helpers/favorite/get_product_list.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/state/provider/wishlist_controller.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class FavoriteController {
  FavoriteController._();

  

  static Stream<dynamic> getUserStream() => AuthRepository().userData();

  static Stream<dynamic> getProductStream(String productId) =>
      UiDetailsGet().getEachProduct(productId);

  

  static List<dynamic> parseFavorites(Map<String, dynamic> userDoc) =>
      userDoc['favorites'] as List<dynamic>? ?? [];

  static ProductModel? parseProduct(AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) =>
      getProductList(snapshot);

 
  static void syncWishlist(
    BuildContext context,
    ProductModel model,
    int variantIndex,
  ) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<WishlistController>().addToWishlist(model, variantIndex),
    );
  }

 
  static void removeFavorite({
    required BuildContext context,
    required String productId,
    required int variantIndex,
  }) {
    context.read<AuthBloc>().add(
          MakeandRmoveFavorite(
            id: productId,
            variantIndex: variantIndex,
            value: false,
          ),
        );
  }

  

  static void showRemovedSnackBar(BuildContext context, String productName) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar('$productName removed'),
    );
  }

  static void showUnavailableRemovedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      _buildSnackBar('Unavailable item removed from your wishlist.'),
    );
  }

  static SnackBar _buildSnackBar(String message) {
    return SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    );
  }

  

  static void goToProductDetail({
    required BuildContext context,
    required ProductModel product,
    required int variantIndex,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProductDetailPage(product: product, variantIndex: variantIndex),
      ),
    );
  }

  

  static double discountedPrice({
    required String discount,
    required String price,
  }) =>
      afterProductDiscount(discount: discount, price: price);

  static String formatPrice(double amount) =>
      NumberFormat('#,###', 'en_IN').format(amount.toInt());

  static bool hasDiscount(String discount) =>
      int.tryParse(discount) != null && int.parse(discount) > 0;
}