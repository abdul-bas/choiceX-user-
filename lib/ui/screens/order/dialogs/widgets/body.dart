
  import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:coice/ui/screens/order/dialogs/widgets/button.dart';
import 'package:coice/ui/screens/order/dialogs/widgets/info_card.dart';
import 'package:coice/ui/screens/order/dialogs/widgets/journey_timeline.dart';
import 'package:flutter/material.dart';

  Widget buildStatusDialogBody(
      StatusConfig cfg, bool isRejected, BuildContext context,{required String orderId}) {
    return Container(
      color: isRejected
          ? AppColors.surfaceError                     
          : AppColors.surfaceWhite,                     
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cfg.headline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: isRejected
                  ? AppColors.dangerDark               
                  : AppColors.textNavy,                  
              letterSpacing: -0.3,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            cfg.subline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: isRejected
                  ? AppColors.dangerLight               
                  : AppColors.textNavy.withValues(alpha: 0.45), 
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          if (!isRejected) ...[
            buildJourneyTimeline(cfg),
            const SizedBox(height: 24),
          ],

          buildInfoCard(cfg, isRejected),
          const SizedBox(height: 24),
        buildButton(cfg, context,orderId: orderId),
        ],
      ),
    );
  }