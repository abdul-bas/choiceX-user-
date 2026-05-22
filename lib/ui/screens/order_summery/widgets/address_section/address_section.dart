

import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/order_summery/controller/controller.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/action_button.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_cart.dart';

import 'package:flutter/material.dart';

Widget buildAddressSection(
  BuildContext context,
  AddressProvider provider,
) {
  final address = provider.defaultAddress;
  final index = provider.defaultIndex;
  if (address == null || index == null) return const SizedBox();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          Row(
            children: [
              buildActionButton(
                icon: Icons.swap_horiz_rounded,
                label: 'Change',
                onTap: () => OrderSummaryController.showAddressSelector(
                    context, provider),
              ),
              const SizedBox(width: 8),
              buildActionButton(
                icon: Icons.edit_outlined,
                label: 'Edit',
                onTap: () =>OrderSummaryController.goToEditAddress(    
                  context: context,
                  address: address,
                  index: index,
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      buildAddressCard(address),
    ],
  );
}