
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/constants/enums/order_status.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/ui/screens/order_details/controller/controller.dart';
import 'package:coice/ui/screens/order_details/dialogs/cancel_dialog/cancel_dialog.dart';
import 'package:coice/ui/screens/order_tracking/order_taraking_screen.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';


class ActiveSection extends StatelessWidget {
  const ActiveSection({
    super.key,
    required this.items,
    required this.expectedDeliveryDate,
    required this.today,
    required this.currentDay,
  });

  final OrderModel items;
  final String expectedDeliveryDate;
  final String today;
  final DateTime currentDay;

  @override
  Widget build(BuildContext context) {
    final isArrivingToday = OrderDetailLogic.isArrivingToday(
      expectedDeliveryDate, today,
    );
    final isOverdue = OrderDetailLogic.isOverdue(currentDay, items.expectedDate);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: TextInter(
              text: expectedDeliveryDate,
              letterSpacing: 0.5,
              fontSize: 17,
            ),
          ),
          TextInter(
            text: isArrivingToday
                ? 'Arriving Today'
                : isOverdue
                    ? ''
                    : 'Expected delivery',
            color: isArrivingToday
                ? AppColors.success                   
                : AppColors.brand,                     
            letterSpacing: 0.5,
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 320,
            child: Column(
              children: [
                const Divider(thickness: 2, color: AppColors.black26),
                Row(
                  children: List.generate(
                    OrderStatus.values.length,
                    (index) {
                      final status = OrderStatus.values[index];
                      final isStatus = OrderDetailLogic.isActiveStatus(
                        status, items.itemStatus,
                      );
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(3),
                              ),
                              border: isStatus
                                  ? const Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: AppColors.brand, 
                                      ),
                                    )
                                  : null,
                            ),
                            child: Column(
                              children: [
                                TextInter(
                                  fontSize: 11,
                                  letterSpacing: 0.3,
                                  text: status.name,
                                  color: isStatus
                                      ? AppColors.brand  
                                      : AppColors.black,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5),
                                isStatus
                                    ? Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: AppColors.brand, 
                                      )
                                    : const SizedBox(height: 3),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
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
                if (items.itemStatus != 'Cancelled' &&
                    items.itemStatus != 'Delivered') ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => showCancelDialog(context, items),
                    child: const Text(
                      'Cancel Order',
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
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}