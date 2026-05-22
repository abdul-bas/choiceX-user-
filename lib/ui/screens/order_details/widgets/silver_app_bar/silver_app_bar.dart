import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/repository/order_repository.dart';
import 'package:coice/ui/screens/cart/my_cart.dart';
import 'package:coice/ui/screens/order_details/controller/controller.dart';
import 'package:coice/ui/screens/order_details/widgets/silver_app_bar/active_section.dart';
import 'package:coice/ui/screens/order_details/widgets/silver_app_bar/cancelled_section.dart';
import 'package:coice/ui/screens/order_details/widgets/silver_app_bar/delivered_section.dart';
import 'package:flutter/material.dart';

class OrderSliverAppBar extends StatelessWidget {
  const OrderSliverAppBar({
    super.key,
    required this.items,
    required this.newStatus,
    required this.isValidate,
    required this.isCancelled,
  });

  final OrderModel items;
  final String newStatus;
  final bool isValidate;
  final bool isCancelled;

  @override
  Widget build(BuildContext context) {
    final expectedDate = OrderDetailLogic.expectedDeliveryDate(items);
    final today = OrderDetailLogic.today();
    final currentDay = DateTime.now();
    final refundCutoff = OrderDetailLogic.refundCutoffDay();

    final isDelivered = OrderDetailLogic.isDelivered(items);
    final isCancelledState =
        OrderDetailLogic.isCancelledState(items, isCancelled);

    if (isValidate) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await OrderRepository().updateAsRead(items.orderId);
      });
    }

    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.surfaceLight,
      elevation: 1,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: AppColors.black87),
      ),
      title: const Text(
        'Order Details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: AppColors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MyCartPage()),
          ),
          icon: const Icon(
            Icons.shopping_cart,
            size: 23,
            color: AppColors.textMuted,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: isDelivered
            ? DeliveredSection(
                items: items,
                newStatus: newStatus,
                showRefundDay: refundCutoff,
              )
            : isCancelledState
                ? CancelledSection(items: items)
                : ActiveSection(
                    items: items,
                    expectedDeliveryDate: expectedDate,
                    today: today,
                    currentDay: currentDay,
                  ),
      ),
      expandedHeight: 300,
    );
  }
}
