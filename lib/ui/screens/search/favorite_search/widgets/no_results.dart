
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
class NoResults extends StatelessWidget {
  const NoResults({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowFaintest,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:  Icon(
              Icons.search_off_rounded,
              size: 36,
              color: AppColors.brandMuted,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'No matches found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.orderEmptyHeading,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            query.isNotEmpty
                ? 'Nothing in your wishlist\nmatches "$query"'
                : 'Your wishlist is empty',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.orderEmptySubtext,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}