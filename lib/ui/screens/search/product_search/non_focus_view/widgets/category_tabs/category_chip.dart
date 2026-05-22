 
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildNonFocusCategoryChip(
  BuildContext context,
  int index,
  String tag,
  Map<String, dynamic> data,
  List<ProductModel> products,
) {
  return Consumer<ProductSearchController>(
    builder: (context, value, child) {
      final isSelected = value.filterTagsIndex == index;
      return GestureDetector(
        onTap: () => context
            .read<ProductSearchController>()
            .setCategoryIndexAndProduct(index, products, data['name']),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brand : AppColors.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: isSelected ? AppColors.brand : AppColors.grey200,
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.brandShadow,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.shadowFaint,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: Text(
            tag,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.specValueMuted,
              fontSize: 12.5,
              fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: -0.1,
            ),
          ),
        ),
      );
    },
  );
}