import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/ui/screens/favorite/controller/controller.dart';
import 'package:coice/ui/screens/favorite/widgets/empty_state.dart';
import 'package:coice/ui/screens/favorite/widgets/magazine_card.dart';
import 'package:coice/ui/screens/favorite/widgets/unavailable_item.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FavoriteController.getUserStream(),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppColors.surfaceWhite,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final userDoc = userSnapshot.data!.data() as Map<String, dynamic>;
        final favoritesList = FavoriteController.parseFavorites(userDoc);

        if (favoritesList.isEmpty) return const EmptyState();

        return Scaffold(
          backgroundColor: AppColors.surfaceWhite,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Text(
                      '${favoritesList.length} item${favoritesList.length > 1 ? 's' : ''} in your wishlist',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSubdued,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.58,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final fav = favoritesList[index];
                        final int vi = fav['variantIndex'];
                        final String id = fav['productId'];

                        return StreamBuilder(
                          stream: UiDetailsGet().getEachProduct(id),
                          builder: (context, productSnapshot) {
                            final result = handleSnapshot(productSnapshot);
                            if (result != null) return result;

                            final model = FavoriteController.parseProduct(
                                productSnapshot);

                            if (model == null) {
                              return UnavailableItem(
                                onRemove: () {
                                  FavoriteController.removeFavorite(
                                    context: context,
                                    productId: id,
                                    variantIndex: vi,
                                  );
                                  FavoriteController
                                      .showUnavailableRemovedSnackBar(context);
                                },
                              );
                            }

                            final String oP = model.variants[vi]['price'];
                            final String dc = model.variants[vi]['discount'];

                            final double discPrice =
                                FavoriteController.discountedPrice(
                              discount: dc,
                              price: oP,
                            );
                            final String fmtDisc =
                                FavoriteController.formatPrice(discPrice);
                            final String fmtOrig =
                                FavoriteController.formatPrice(
                                    double.parse(oP));
                            final bool hasDisc =
                                FavoriteController.hasDiscount(dc);

                            final Uint8List bytes =
                                base64Decode(model.variants[vi]['images'][0]);

                            FavoriteController.syncWishlist(context, model, vi);

                            return MagazineCard(
                              bytes: bytes,
                              brand: model.brand,
                              name: model.productName,
                              fmtDisc: fmtDisc,
                              fmtOrig: fmtOrig,
                              discount: dc,
                              hasDiscount: hasDisc,
                              onRemove: () {
                                FavoriteController.removeFavorite(
                                  context: context,
                                  productId: model.id,
                                  variantIndex: vi,
                                );
                                FavoriteController.showRemovedSnackBar(
                                    context, model.productName);
                              },
                              onView: () =>
                                  FavoriteController.goToProductDetail(
                                context: context,
                                product: model,
                                variantIndex: vi,
                              ),
                            );
                          },
                        );
                      },
                      childCount: favoritesList.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
