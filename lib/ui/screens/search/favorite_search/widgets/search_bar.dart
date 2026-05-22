

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/wishlist_controller.dart';
import 'package:flutter/material.dart';
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, required this.controller});

  final WishlistController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            Icons.search_rounded,
            color: AppColors.searchIconColor,
            size: 19,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller.textEditingController,
              onChanged: controller.setSearchQuery,
              autofocus: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.orderEmptyHeading,
              ),
              decoration: const InputDecoration(
                hintText: 'Search your wishlist…',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.searchIconColor,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              controller.textEditingController.clear();
              controller.setSearchQuery('');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.searchClearBtnBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}