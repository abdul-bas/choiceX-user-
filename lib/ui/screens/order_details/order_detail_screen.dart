import 'dart:async';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/routes/push_function.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/data/models/retrun_and_refund/return_and_refund.dart';
import 'package:coice/data/remote/firebase_service.dart';
import 'package:coice/data/repository/order_repository.dart';
import 'package:coice/state/provider/order_detail_provider.dart';
import 'package:coice/ui/screens/order/dialogs/status_update_dialog.dart';
import 'package:coice/ui/screens/order/listeners/order_listener.dart';
import 'package:coice/ui/screens/product/listeners/rating_listener.dart';
import 'package:coice/ui/screens/order_details/widgets/payment_card/payment_card.dart';
import 'package:coice/ui/screens/order_details/widgets/product_details_card/product_detail_card.dart';
import 'package:coice/ui/screens/order_details/widgets/silver_app_bar/silver_app_bar.dart';
import 'package:coice/ui/screens/order_details/widgets/user_details_card/user_details_cart.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.items});

  final OrderModel items;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}
class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final TextEditingController reviewController =
      TextEditingController();

  StreamSubscription? _orderSubscription;

  @override
  void initState() {
    super.initState();

    context.read<OrderDetailProvider>().checkAndShowRating(
      context,
      widget.items,
      reviewController,
    );

    _listenOrderUpdates();
  }

  void _listenOrderUpdates() {
    _orderSubscription = OrderRepository()
        .watchOrderExists(widget.items.orderId)
        .listen((data) {

      if (data == null) return;

      final orderExists =
          ReturnRequestModel.fromJson(data);

      if (!orderExists.isRead && mounted) {
        showDialog(
          context: context,
          barrierColor: AppColors.overlayBarrier,
          builder: (_) => StatusUpdateDialog(orderId: orderExists.orderId,
            newStatus: orderExists.status,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    reviewController.dispose();
    _orderSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return requestUpdateValidation(
      child: (newStatus, isValidate, isCancelled) {
        return Scaffold(
          backgroundColor: AppColors.surfaceLight,
          body: ratingListener(
            child: CustomScrollView(
              slivers: [
                OrderSliverAppBar(
                  items: widget.items,
                  newStatus: newStatus,
                  isValidate: isValidate,
                  isCancelled: isCancelled,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final snapshot =
                                await UiDetailsGet()
                                    .particularProductGet(
                                      widget.items.productId,
                                    )
                                    .first;

                            if (!snapshot.exists) return;

                            final product =
                                ProductModel.fromMap(
                              snapshot.data()
                                  as Map<String, dynamic>,
                            );

                            pushScreen(
                              context,
                              ProductDetailPage(
                                product: product,
                                variantIndex:
                                    widget.items.variantIndex,
                              ),
                            );
                          },
                          child: ProductDetailCard(
                            items: widget.items,
                          ),
                        ),

                        const UserDetailsCard(),

                        PaymentCard(
                          items: widget.items,
                        ),

                        const SizedBox(height: 10),
                      ],
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