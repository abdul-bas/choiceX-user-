
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class BrandSortRow extends StatelessWidget {
  const BrandSortRow({
    super.key,
    required this.brandName,
    required this.productCount,
  });

  final String brandName;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3.5,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.brand,                
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'All $brandName',
              style: const TextStyle(
                color: AppColors.textDark,       
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 11),
          child: Text(
            '$productCount items available',
            style: const TextStyle(
              color: AppColors.textHint,               
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
          Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.brandSubtle,                  
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.shadowBrand,              
          width: 1,
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_offer_rounded, size: 13, color: AppColors.brand),
          SizedBox(width: 5),
          Text(
            'Best Picks',
            style: TextStyle(
              color: AppColors.brand,                
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
        ],
      ),
    );
  }
}
