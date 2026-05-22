import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/more/listeners/notification_listener.dart';
import 'package:coice/ui/screens/product/widget/bottom_bar/build_bottom_bar.dart';
import 'package:coice/ui/screens/product/widget/chat_button/build_chat_button.dart';
import 'package:coice/ui/screens/product/widget/section_label/build_section_label.dart';
import 'package:coice/ui/screens/product/widget/additional_images/build_dditional_images.dart';
import 'package:coice/ui/screens/product/widget/silver_app_bar/build_sliver_app_bar.dart';
import 'package:coice/ui/screens/product/widget/tile_row/build_title_row.dart';
import 'package:coice/ui/screens/product/widget/product-datails_table/product_detail_table.dart';
import 'package:coice/ui/screens/product/widget/simular_product/build_simular_product.dart';
import 'package:coice/ui/screens/cart/listeners/cart_listener.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:coice/ui/screens/product/widget/rating_card/rating_card_widget.dart';
import 'package:coice/ui/screens/product/widget/variants/variants_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.variantIndex,
  });

  final ProductModel product;
  final int variantIndex;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ValueNotifier<int> toggleVariantIndex = ValueNotifier(0);
  final ValueNotifier<int> indcatorIndex = ValueNotifier(0);
  bool _recentActivityFired = false;
  @override
  void initState() {
    toggleVariantIndex.value = widget.variantIndex;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_recentActivityFired) {
      _recentActivityFired = true;
      context.read<RecentSearchBloc>().add(
            RecentActivityEvent(
              productId: widget.product.id,
              variantIndex: widget.variantIndex.toString(),
            ),
          );
    }
  }

  @override
  void dispose() {
    toggleVariantIndex.dispose();
    indcatorIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return addCartListener(
      child: Scaffold(
        backgroundColor: AppColors.surfaceLight,
        body: notificationListener(
          child: SafeArea(
            child: ValueListenableBuilder<int>(
              valueListenable: toggleVariantIndex,
              builder: (context, value, _) {
                return Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          buildSliverAppBar(
                            context,
                            value,
                            widget.product,
                            indcatorIndex,
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                buildTitleRow(value, widget.product),
                                const SizedBox(height: 20),
                                buildChatButton(context, value, widget.product),
                                const SizedBox(height: 24),
                                buildSectionLabel('Options'),
                                const SizedBox(height: 10),
                                VariantsWidget(
                                  value: value,
                                  product: widget.product,
                                  toggleVariantIndex: toggleVariantIndex,
                                ),
                                const SizedBox(height: 24),
                                buildSectionLabel('Description'),
                                const SizedBox(height: 10),
                                Text(
                                  widget.product.description,
                                  style: const TextStyle(
                                    height: 1.65,
                                    fontSize: 14,
                                    color: AppColors.black87,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ValueListenableBuilder<int>(
                                  valueListenable: toggleVariantIndex,
                                  builder: (context, value, _) =>
                                      RatingCardWidget(
                                    productId: widget.product.id,
                                    variantindex: value,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ValueListenableBuilder<int>(
                                  valueListenable: toggleVariantIndex,
                                  builder: (context, value, _) =>
                                      BuildSimilarProduct(
                                    product: widget.product,
                                    variantIndex: value,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                buildSectionLabel('Product Details'),
                                const SizedBox(height: 10),
                                buildProductDetailsTable(value, widget.product),
                                const SizedBox(height: 24),
                                if (widget.product.imges.isNotEmpty)
                                  buildAdditionalImages(widget.product.imges),
                                const SizedBox(height: 32),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.product.status.toLowerCase() == 'live')
                      buildBottomBar(value, widget.product, 1),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
