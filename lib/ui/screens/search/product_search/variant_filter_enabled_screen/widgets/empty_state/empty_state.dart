
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/search/product_search/variant_filter_enabled_screen/widgets/empty_state/set_filter_button.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantEmptyState(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: AppColors.brandFaint,
                  shape: BoxShape.circle,
                ),
                child:  Icon(
                  Icons.filter_alt_off_outlined,
                  size: 38,
                  color: AppColors.brandMuted,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No Matching Products',
                style: TextStyle(
                  color: AppColors.textDeep,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We couldn\'t find any products for these filters\nTry different options.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textCoolGrey,
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              buildSetFiltersButton(context),
            ],
          ),
        ),
      ),
    ],
  );
}