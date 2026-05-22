
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:coice/state/provider/product_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildProductSearchSearchField(
  ProductSearchController controller,
  BuildContext context,
) {
  return Expanded(
    child: Container(
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey200),
      ),
      child: TextFormField(
        controller: controller.messageInputCtrl,
        onFieldSubmitted: (value) =>
            context.read<RecentSearchBloc>().add(RecentSearchSet(text: value)),
        onChanged: (value) =>
            controller.suggestions(controller.productList, value),
        style: const TextStyle(
          color: AppColors.textDeep,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: const TextStyle(
            color: AppColors.inputHint,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              Icons.search_rounded,
              size: 20,
              color: AppColors.brandSoft,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: GestureDetector(
            onTap: () => controller.messageInputCtrl.clear(),
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.cancel_rounded,
                size: 18,
                color: AppColors.inputHint,
              ),
            ),
          ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    ),
  );
}