
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_card.dart';
import 'package:coice/ui/common_widgets/loading_indicator.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSelectorSheet extends StatelessWidget {
  const AddressSelectorSheet({super.key, required this.addresses});

  final List<AddressModel> addresses;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: const BoxDecoration(
        color: AppColors.addressSheetBg,                        
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildAddressSheetHeader(context),
          Expanded(
            child: Consumer<AddressProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) return showLoadingIndicator();
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == provider.defaultIndex;
                    return InkWell(                           
                      onTap: () async =>
                          await provider.toggleDefault(index),
                      borderRadius: BorderRadius.circular(18),
                      child: buildAddressSheetCard(
                          addresses[index], isSelected),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}