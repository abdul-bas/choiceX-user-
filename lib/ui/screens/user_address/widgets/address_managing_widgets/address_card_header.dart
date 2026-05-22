
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/common/address_icons.dart';
import 'package:coice/core/utils/helpers/common/cap.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/ui/screens/user_address/dialogs/address_delete_dialog.dart';
import 'package:coice/ui/screens/user_address/edit_user_address/edit_address.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/header_button.dart';
import 'package:flutter/material.dart';

class AddressCardHeader extends StatelessWidget {
  final AddressModel address;
  final int index;
  final bool isDefault;

  const AddressCardHeader({super.key, 
    required this.address,
    required this.index,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDefault
            ? AppColors.brand.withValues(alpha: 0.07)
            : AppColors.grey100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 13, 10, 13),
      child: Row(
        children: [
        
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isDefault
                  ? AppColors.brand.withValues(alpha: 0.12)
                  : AppColors.surfaceWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDefault
                    ? AppColors.brand.withValues(alpha: 0.25)
                    : AppColors.addressBorder,
              ),
            ),
            child: Icon(
              getAddressIcon(address.nickName),
              color: AppColors.brand,
              size: 20,
            ),
          ),
          const SizedBox(width: 11),

       
          Expanded(
            child: Row(
              children: [
                Text(
                  cap(address.nickName),
                  style: TextStyle(
                    color: isDefault ? AppColors.brand : AppColors.addressHeading,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                if (isDefault) ...[
                  const SizedBox(width: 8),
                  Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.promoSuccess.withValues(alpha: 0.40),
        ),
      ),
      child: Text(
        'DEFAULT',
        style: TextStyle(
          color: AppColors.successIcon,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.9,
        ),
      ),
    )
                ],
              ],
            ),
          ),

         
          AddressHeaderBtn(
            icon: Icons.edit_outlined,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditAddress(address: address, index: index),
              ),
            ),
            isDefault: isDefault,
          ),
          const SizedBox(width: 6),

          AddressHeaderBtn(
            icon: Icons.delete_outline_rounded,
            onTap: () => showDialog(
              context: context,
              builder: (_) => showDeleteAddressDialog(context, index),
            ),
            isDefault: isDefault,
            isDanger: true,
          ),
        ],
      ),
    );
  }
}
