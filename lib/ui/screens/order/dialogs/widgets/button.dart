import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/status_config/status_config.dart';
import 'package:coice/data/repository/order_repository.dart';
import 'package:flutter/material.dart';

Widget buildButton(StatusConfig cfg, BuildContext context,
    {required String orderId}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cfg.color.withValues(alpha: 0.85), cfg.color],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: cfg.color.withValues(alpha: 0.3),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          OrderRepository().updateAsRead(orderId);
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          foregroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          'Understood',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}
