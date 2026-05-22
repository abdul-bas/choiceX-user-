
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddressInfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final int maxLines;
  final bool isDefault;

  const AddressInfoRow({
    super.key,
    required this.icon,
    required this.value,
    required this.isDefault,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDefault
                ? AppColors.brand.withValues(alpha: 0.10)
                : AppColors.surfacePageGrey,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: isDefault
                  ? AppColors.brand.withValues(alpha: 0.18)
                  : AppColors.addressBorder,
            ),
          ),
          child: Icon(
            icon,
            size: 15,
            color: isDefault ? AppColors.brand : AppColors.addressSubtext,
          ),
        ),
        const SizedBox(width: 10),

     
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              value,
              style: TextStyle(
                color: isDefault
                    ? AppColors.brand.withValues(alpha: 0.85)
                    : AppColors.textPrimary,
                fontSize: 13.5,
                fontWeight: isDefault ? FontWeight.w600 : FontWeight.w500,
                height: 1.4,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}