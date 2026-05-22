
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:flutter/material.dart';

Widget buildProductSearchEmptyState(ProductSearchController controller) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.brandFaint,
            shape: BoxShape.circle,
          ),
          child:  Icon(
            Icons.search_off_rounded,
            size: 36,
            color: AppColors.brandMuted,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'No results found',
          style: TextStyle(
            color: AppColors.textDeep,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 6),
        ValueListenableBuilder(
          valueListenable: controller.messageInputCtrl,
          builder: (_, val, __) => Text(
            'No match for "${controller.messageInputCtrl.text}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textCoolGrey,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.brandGhost,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.brandBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 14,
                color: AppColors.brandSoft,
              ),
              const SizedBox(width: 6),
              Text(
                'Try a different keyword',
                style: TextStyle(
                  color: AppColors.brandStrong,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}