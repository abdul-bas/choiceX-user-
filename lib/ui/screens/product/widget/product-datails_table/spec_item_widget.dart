
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/product/model/spec_item.dart';
import 'package:coice/ui/screens/product/widget/product-datails_table/build_value.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecItemWidget extends StatelessWidget {
  const SpecItemWidget({super.key, required this.item});

  final SpecItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 118,
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.brandSubtle,          
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              item.field,
              style: GoogleFonts.dmSans(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: AppColors.specValueMuted,       
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.specDot,            
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: buildValue(item),
            ),
          ),
        ],
      ),
    );
  }
}
