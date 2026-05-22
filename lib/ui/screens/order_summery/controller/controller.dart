import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/routes/push_function.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_selector_sheet.dart';
import 'package:coice/ui/screens/promo_code_pop/promo_code_pop.dart';
import 'package:coice/ui/screens/user_address/add_user_address/add_address.dart';
import 'package:coice/ui/screens/user_address/edit_user_address/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummaryController {
  OrderSummaryController._();

  static void showCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Consumer<AddressProvider>(
              builder: (context, provider, child) {
                final address = provider.defaultAddress;
                if (address == null) return const SizedBox();
                return PromoCodePop(address: address.fullAddress);
              },
            ),
          ),
        );
      },
    );
  }

  static void showAddressSelector(
      BuildContext context, AddressProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => AddressSelectorSheet(addresses: provider.addresses),
    );
  }

  static void goToEditAddress({
    required BuildContext context,
    required AddressModel address,
    required int index,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditAddress(address: address, index: index),
      ),
    );
  }

  static void goToAddAddress({
    required BuildContext context,
    required VoidCallback onSuccess,
  }) {
    pushScreen(
      context,
      AddAddress(isDefault: false, navigation: onSuccess),
    );
  }
}
