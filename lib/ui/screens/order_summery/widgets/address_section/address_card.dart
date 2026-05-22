import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/common/address_colors.dart';
import 'package:coice/core/utils/helpers/common/address_icons.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:flutter/material.dart';

Widget buildAddressSheetCard(AddressModel address, bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isSelected ? AppColors.brand : AppColors.surfaceWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(
        color: isSelected ? AppColors.brand : AppColors.grey200,
        width: isSelected ? 1.5 : 1,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: AppColors.shadowBrand,
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ]
          : [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.white.withValues(alpha: 0.2)
                : getAddressColor(address.nickName).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            getAddressIcon(address.nickName),
            size: 20,
            color: isSelected
                ? AppColors.white
                : getAddressColor(address.nickName),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    address.nickName,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: isSelected
                          ? AppColors.white
                          : AppColors.addressHeading,
                    ),
                  ),
                  if (address.isDefault) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.white.withValues(alpha: 0.25)
                            : AppColors.brandSubtle,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'DEFAULT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? AppColors.white : AppColors.brand,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                address.location,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? AppColors.white.withValues(alpha: 0.85)
                      : AppColors.orderHistoryBadge,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                address.fullAddress,
                style: TextStyle(
                  fontSize: 13,
                  color: isSelected
                      ? AppColors.white.withValues(alpha: 0.85)
                      : AppColors.orderHistoryBadge,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 12,
                    color: isSelected
                        ? AppColors.white.withValues(alpha: 0.7)
                        : AppColors.addressSubtext,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    address.phoneNumber,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? AppColors.white.withValues(alpha: 0.7)
                          : AppColors.addressSubtext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (address.isDefault)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? AppColors.white : AppColors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.white : AppColors.addressBorder,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check,
                    size: 13, color: AppColors.addressCheckTick)
                : null,
          ),
      ],
    ),
  );
}
