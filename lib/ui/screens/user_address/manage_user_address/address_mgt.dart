
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/action_button.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/address_card.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/adress_empty_mgt.dart';
import 'package:coice/ui/screens/user_address/widgets/address_managing_widgets/header.dart';
import 'package:coice/ui/common_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddressCredScreen extends StatelessWidget {
  const AddressCredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.addressSheetBg,
      appBar: buildAddressHeader(context, 0),
      body: Consumer<AddressProvider>(
        builder: (context, provider, child) {
          final addresses = provider.addresses;
          if (provider.isLoading) return showLoadingIndicator();
          return Column(
            children: [
              Expanded(
                child: addresses.isEmpty
                    ? buildEmpty()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        itemCount: addresses.length,
                        itemBuilder: (_, i) => InkWell(
                          onTap: () async => provider.toggleDefault(i),
                          child: AddressCard(address: addresses[i], index: i),
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: buildFAB(context),
    );
  }
}



