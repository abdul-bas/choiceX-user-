
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceSearch,
      body: Column(
        children: [
          Container(
            color: AppColors.surfaceDarkHeader,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'My Wishlist',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
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
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      size: 38,
                      color: AppColors.brand,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Nothing saved yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.orderEmptyHeading,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Items you save will appear here',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppColors.orderEmptySubtext,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}