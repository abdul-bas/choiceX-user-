import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:coice/ui/screens/order/widgets/history.dart';
import 'package:coice/ui/screens/order/widgets/my_order.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'My Orders',
            style: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => OrderController.goToCart(context),
              icon: const Icon(
                Icons.shopping_cart,
                color: AppColors.textMuted,
              ),
            ),
          ],
          bottom: TabBar(
            dividerHeight: 0,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            indicatorColor: AppColors.brand,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.textMuted,
            tabs: const [
              Tab(text: 'My Order'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: OrderController.getOrdersStream(),
          builder: (context, snapshot) {
            final result = handleSnapshot(snapshot);
            if (result != null) return result;

            return TabBarView(
              children: [
                MyOrderScreen(ordersDoc: snapshot.data!.docs),
                HistoryScreen(ordersDoc: snapshot.data!.docs),
              ],
            );
          },
        ),
      ),
    );
  }
}
