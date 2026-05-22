import 'package:coice/core/constants/app_strings/order_cancel_reason.dart';
import 'package:coice/data/models/order_model.dart';
import 'package:coice/state/bloc/order/order_bloc/order_bloc.dart';
import 'package:coice/state/bloc/order/order_event/cancellation_request_event.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/buttons.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/chips.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/detail_field.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/header.dart';
import 'package:coice/ui/screens/order_details/widgets/dialogs/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void showCancelDialog(BuildContext context, OrderModel items) {
  final TextEditingController reasonController = TextEditingController();
  final ValueNotifier<bool> showError = ValueNotifier(false);
  final ValueNotifier<String> selectedReason = ValueNotifier('Changed my mind');

  

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
                    color: Colors.red.shade50,
                    shadowColor: Colors.red,
                    icon: Icons.cancel_outlined,
                    iconColor: Colors.red.shade600,
                    title: 'Cancel Order?',
                    subtitle: "Please tell us why you're cancelling",
                  ),
              
               
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DialogLabel('Reason for Cancellation'),
                        const SizedBox(height: 8),
                        ReasonChips(
                          reasons: orderCancelReasons,
                          selected: selected,
                          selectedColor: Colors.red.shade600,
                          onTap: (r) {
                            selectedReason.value = r;
                            showError.value = false;
                          },
                        ),
                        const SizedBox(height: 16),
                        DialogLabel('Additional Details'),
                        const SizedBox(height: 8),
                        DetailField(
                          controller: reasonController,
                          focusColor: Colors.red.shade300,
                        ),
                        const SizedBox(height: 6),
                  
                        ValueListenableBuilder<bool>(
                          valueListenable: showError,
                          builder: (_, show, __) => show
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 4),
                                  child: Row(
                                    children: [
                                      Icon(Icons.info_outline,
                                          size: 13, color: Colors.red.shade600),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Please select a reason",
                                        style: GoogleFonts.urbanist(
                                          color: Colors.red.shade600,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                  
                        const SizedBox(height: 14),
                        DialogButtons(
                          cancelLabel: 'Keep Order',
                          confirmLabel: 'Yes, Cancel',
                          confirmColor: Colors.red.shade600,
                          shadowColor: Colors.red,
                          onCancel: () => Navigator.pop(ctx),
                          onConfirm: () {
                            if (selected.isEmpty) {
                              showError.value = true;
                              return;
                            }
                            final finalReason =
                                '${selected}_${reasonController.text.trim()}';
                            context.read<OrderBloc>().add(
                                  CancellationRequestEvent(
                                    orderId: items.orderId,
                                    reason: finalReason,
                                  ),
                                );
                            Navigator.pop(ctx);
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
