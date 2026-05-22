
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_selector_sheet.dart';
import 'package:flutter/material.dart';


void showAddressSelector(
    BuildContext context, AddressProvider provider) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,                  
    builder: (_) =>
        AddressSelectorSheet(addresses: provider.addresses),
  );
}

 

  

