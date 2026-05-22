import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/models/retrun_and_refund/return_and_refund.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:coice/data/repository/order_repository.dart';
import 'package:coice/ui/screens/order_details/controller/controller.dart';
import 'package:coice/ui/screens/order_details/dialogs/return_request_dialog/return_request_dialog.dart';
import 'package:coice/ui/screens/order_tracking/order_taraking_screen.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';

class DeliveredSection extends StatelessWidget {
  DeliveredSection({
    super.key,
    required this.items,
    required this.newStatus,
    required this.showRefundDay,
  });

  final OrderModel items;
  final String newStatus;
  final DateTime showRefundDay;
  final OrderRepository orderRepository = OrderRepository();

  @override
  Widget build(BuildContext context) {
    final canReturn = OrderDetailLogic.canReturn(items, showRefundDay);

    return FutureBuilder(
      future: orderRepository.containsOrder(items.orderId),
      builder: (context, asyncSnapshot) {
        final state = handleSnapshot(asyncSnapshot);
        if (state != null) return state;

        final bool isContains = asyncSnapshot.data as bool;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.success,  
                child: const Icon(
                  Icons.check_sharp,
                  color: AppColors.white,             
                  size: 45,
                ),
              ),
              const SizedBox(height: 10),
               TextInter(
                text: 'ORDER DELIVERED',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
               SizedBox(height: 5),
               TextInter(
                text: 'Your order has been delivered successfully',
                fontSize: 12,
                color: AppColors.black54,            
                letterSpacing: 0.3,
              ),
              const SizedBox(height: 13),
              AuthButton(
                width: 180,
                text: 'Order Tracking',
                textColor: AppColors.white,         
                hight: 35,
                fontSize: 10,
                radius: 10,
                function: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderTrackingScreen(order: items),
                  ),
                ),
              ),
              if (canReturn) ...[
                const SizedBox(height: 9),
                isContains
                    ? StreamBuilder<QuerySnapshot<Object?>>(
                        stream: orderRepository.getRefundStatus(items.orderId),
                        builder: (context, asyncSnapshot) {
                          final state = handleSnapshot(asyncSnapshot);
                          if (state != null) return state;
                          final doc = asyncSnapshot.data!.docs.first;
                          final refundData = ReturnRequestModel.fromJson(
                            doc.data() as Map<String, dynamic>,
                          );
                          final cleanStatus = refundData.status
                              .replaceAll(RegExp(r'[()]'), '');
                          return Text(
                            cleanStatus,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: StatusConfig.from(cleanStatus).color,
                              letterSpacing: 0.2,
                            ),
                          );
                        },
                      )
                    : GestureDetector(
                        onTap: () => showReturnDialog(context, items),
                        child: const Text(
                          'Return',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: AppColors.dangerMid,       
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.dangerBorder,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
              ],
            ],
          ),
        );
      },
    );
  }
}