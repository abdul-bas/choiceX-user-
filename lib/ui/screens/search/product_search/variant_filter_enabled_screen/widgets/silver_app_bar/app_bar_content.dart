import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:flutter/material.dart';

Widget buildFilterVariantAppBarContent(List<ProductModel> products) {
  return SafeArea(
    bottom: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtered Results',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Showing ${products.length} matching product${products.length != 1 ? 's' : ''}',
                  style: TextStyle(
                    color: AppColors.white75,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}