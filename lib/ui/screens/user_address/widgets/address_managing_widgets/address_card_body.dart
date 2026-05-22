

import 'package:coice/data/models/address_model.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/divider.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/info_row.dart';
import 'package:flutter/material.dart';

class AddressCardBody extends StatelessWidget {
  final AddressModel address;
  final bool isDefault;

 

   const AddressCardBody({super.key, required this.address, required this.isDefault});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        children: [
          AddressInfoRow(
            icon: Icons.call_outlined,
            value: address.phoneNumber,
            isDefault: isDefault,
          ),
          AddressDivider(isDefault: isDefault),
          AddressInfoRow(
            icon: Icons.near_me_outlined,
            value: address.location,
            isDefault: isDefault,
          ),
          AddressDivider(isDefault: isDefault),
          AddressInfoRow(
            icon: Icons.home_outlined,
            value: address.fullAddress,
            isDefault: isDefault,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}