import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/address_card_body.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/address_card_header.dart';


import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final int index;

  const AddressCard({super.key, required this.address, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDefault = address.isDefault;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDefault
              ? AppColors.brand.withValues(alpha: 0.2)
              : AppColors.borderLight,
          width: isDefault ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDefault
                ? AppColors.brand.withValues(alpha: 0.10)
                : AppColors.shadowDark,
            blurRadius: isDefault ? 20 : 12,
            spreadRadius: isDefault ? 2 : 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AddressCardHeader(address: address, index: index, isDefault: isDefault),
          AddressCardBody(address: address, isDefault: isDefault),
        ],
      ),
    );
  }
}