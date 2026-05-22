import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/state/provider/wishlist_controller.dart';
import 'package:coice/ui/screens/favorite/widgets/magazine_card.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:coice/ui/screens/search/favorite_search/widgets/empty_search.dart';
import 'package:coice/ui/screens/search/favorite_search/widgets/no_results.dart';
import 'package:coice/ui/screens/search/favorite_search/widgets/search_bar.dart';
import 'package:coice/core/utils/utils/after_product_discount%20.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class FavoriteSearchScreen extends StatelessWidget {
  const FavoriteSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceSearch,
      body: Consumer<WishlistController>(
        builder: (context, controller, _) {
          if (controller.favoritesList.isEmpty) {
            return const EmptySearch();
          }

          final favoritesList = controller.filterFavoritesList;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: AppColors.surfaceSearch,
                elevation: 0,
                scrolledUnderElevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: 68,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.black38,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SearchBarWidget(controller: controller),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
                  child: Row(
                    children: [
                      if (controller.textEditingController.text.isEmpty)
                        Text(
                          favoritesList.isEmpty
                              ? 'No results found'
                              : '${favoritesList.length} item${favoritesList.length > 1 ? 's' : ''} found',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.orderEmptySubtext,
                          ),
                        ),
                      if (controller.textEditingController.text.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            ' Search for  "${controller.textEditingController.text}"',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.orderEmptyHeading,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              if (favoritesList.isEmpty)
                SliverFillRemaining(
                  child: NoResults(
                    query: controller.textEditingController.text,
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
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
                        final model = favoritesList[index];
                        final int vi = controller.filterVariantIndex[index];
                        final String oP = model.variants[vi]['price'];
                        final String dc = model.variants[vi]['discount'];

                        final double discPrice =
                            afterProductDiscount(discount: dc, price: oP);
                        final String fmtDisc = NumberFormat('#,###', 'en_IN')
                            .format(discPrice.toInt());
                        final String fmtOrig = NumberFormat('#,###', 'en_IN')
                            .format(int.parse(oP));

                        final Uint8List bytes =
                            base64Decode(model.variants[vi]['images'][0]);
                        final bool hasDisc =
                            int.tryParse(dc) != null && int.parse(dc) > 0;

                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            context
                                .read<WishlistController>()
                                .addToWishlist(model, vi));

                        return MagazineCard(
                          bytes: bytes,
                          brand: model.brand,
                          name: model.productName,
                          fmtDisc: fmtDisc,
                          fmtOrig: fmtOrig,
                          discount: dc,
                          hasDiscount: hasDisc,
                          onRemove: () {
                            context.read<AuthBloc>().add(
                                  MakeandRmoveFavorite(
                                    id: model.id,
                                    variantIndex: vi,
                                    value: false,
                                  ),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${model.productName} removed'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.all(16),
                              ),
                            );
                          },
                          onView: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                product: model,
                                variantIndex: vi,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: favoritesList.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}