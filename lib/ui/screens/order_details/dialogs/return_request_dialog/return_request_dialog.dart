import 'package:coice/core/constants/app_strings/return_request_reasons.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/models/retrun_and_refund/return_and_refund.dart';
import 'package:coice/state/bloc/order/order_bloc/order_bloc.dart';
import 'package:coice/state/bloc/order/order_event/return_request_event.dart';
import 'package:coice/ui/screens/order/dialogs/status_update_dialog.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/buttons.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/chips.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/detail_field.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/header.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

void showReturnDialog(BuildContext context, OrderModel order) {
  final TextEditingController reasonController = TextEditingController();
  final ValueNotifier<String> selectedReason = ValueNotifier("Damaged Product");

  
  showDialog(
    context: context,
    builder: (ctx) => ValueListenableBuilder<String>(
      valueListenable: selectedReason,
      builder: (context, selected, _) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:  0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
               
                  DialogHeader(
                    color: Colors.orange.shade50,
                    shadowColor: Colors.orange,
                    icon: Icons.assignment_return_outlined,
                    iconColor: Colors.orange.shade700,
                    title: 'Request a Return',
                    subtitle: 'Tell us what went wrong',
                  ),
              
               
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DialogLabel('Reason for Return'),
                        const SizedBox(height: 8),
                        ReasonChips(
                          reasons: returnRequestReasons,
                          selected: selected,
                          selectedColor: Colors.orange.shade700,
                          onTap: (r) => selectedReason.value = r,
                        ),
                        const SizedBox(height: 18),
                        DialogLabel('Additional Details'),
                        const SizedBox(height: 8),
                        DetailField(
                          controller: reasonController,
                          focusColor: Colors.orange.shade400,
                        ),
                        const SizedBox(height: 20),
                        DialogButtons(
                          cancelLabel: 'Cancel',
                          confirmLabel: 'Submit Return',
                          confirmColor: Colors.orange.shade700,
                          shadowColor: Colors.orange,
                          onCancel: () => Navigator.pop(ctx),
                          onConfirm: () {
                            final finalReason =
                                '${selected}_${reasonController.text}';
                            final request = ReturnRequestModel(
                              isRead: true,
                              amount: order.amount,
                              requestId: const Uuid().v1(),
                              orderId: order.orderId,
                              userId: order.userId,
                              sellerId: order.sellerId,
                              paymentId: '',
                              type: 'return',
                              reason: finalReason,
                              status: 'pending',
                              createdAt: DateTime.now(),
                            );
                            context
                                .read<OrderBloc>()
                                .add(CreateReturnRequest(request: request));
                            Navigator.pop(ctx);
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  StatusUpdateDialog(newStatus: 'pending'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
