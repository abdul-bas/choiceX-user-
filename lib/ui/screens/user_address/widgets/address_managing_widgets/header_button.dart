import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class AddressHeaderBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDefault;
  final bool isDanger;

  const AddressHeaderBtn({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isDefault,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color fg = isDanger
        ? AppColors.danger
        : isDefault
            ? AppColors.brand
            : AppColors.addressSubtext;

    final Color bg = isDanger
        ? AppColors.dangerLight
        : isDefault
            ? AppColors.brand.withValues(alpha: 0.10)
            : AppColors.surfaceWhite;

    final Color border = isDanger
        ? AppColors.dangerBorder
        : isDefault
            ? AppColors.brand.withValues(alpha: 0.20)
            : AppColors.addressBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: border),
        ),
        child: Icon(icon, size: 16, color: fg),
      ),
    );
  }
}