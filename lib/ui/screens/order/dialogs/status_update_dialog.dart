import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:coice/ui/screens/order/dialogs/widgets/body.dart';
import 'package:coice/ui/screens/order/dialogs/widgets/header.dart';
import 'package:flutter/material.dart';

class StatusUpdateDialog extends StatelessWidget {
  const StatusUpdateDialog(
      {super.key, required this.newStatus, required this. orderId});

  final String newStatus;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    final cfg = StatusConfig.from(newStatus);
    final isRejected = cfg.statusKey == 'Rejected';

    return Dialog(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: cfg.color.withValues(alpha: 0.18),
              blurRadius: 50,
              spreadRadius: -4,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: AppColors.shadowDialog,
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildStatusDialogHeroHeader(cfg, newStatus),
              buildStatusDialogBody(cfg, isRejected, context, orderId: orderId),
            ],
          ),
        ),
      ),
    );
  }
}
