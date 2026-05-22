
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/recent_search/recent_search_bloc.dart';
import 'package:coice/state/bloc/recent_search/recent_search_event.dart';
import 'package:coice/ui/screens/product/widget/section_label/build_section_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildRecentSearches(
  BuildContext context,
  List<String> searchs,
  TextEditingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSectionLabel('Recent Searches'),
          GestureDetector(
            onTap: () => context
                .read<RecentSearchBloc>()
                .add(RecentSearchClearAll()),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.clearAllBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.clearAllBorder),
              ),
              child: const Text(
                'Clear All',
                style: TextStyle(
                  color: AppColors.clearAllText,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: searchs.asMap().entries.map((e) {
          final index = e.key;
          final text = e.value;

          return GestureDetector(
            onTap: () => controller.text = text,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 7, 6, 7),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.recentChipBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 13,
                    color: AppColors.brandMuted,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.textDeep,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => context
                        .read<RecentSearchBloc>()
                        .add(RecentSearchClear(index: index)),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 13,
                      color: AppColors.inputHint,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}