import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/user_address/controller.dart/controller.dart';
import 'package:coice/ui/screens/user_address/listeners/address_listener.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/addresss_form_section.dart';
import 'package:coice/data/models/address_model.dart';

import 'package:coice/ui/common_widgets/custom_text_button.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EditAddress extends StatelessWidget {
   EditAddress({
    super.key,
    required this.address,
    required this.index,
  });

  final AddressModel address;
  final int index;
final AddressController _controller = AddressController();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Future.microtask(() {
      context.read<AddressProvider>().loadAddress(address);
    });

    return addressListener(
      controller: _controller,
      navigation: () => Navigator.pop(context),
      child: Consumer<AddressProvider>(
        builder: (context, provider, _) {
          return AddressFormSection(
            isDefault: provider.isDefault,
            label: 'Edit',
            addressTypeController: provider.addressTypeController,
            locationController: provider.locationController,
            fullAddressController: provider.fullAddressController,
            phoneNumberController: provider.phoneNumberController,
            formKey: formKey,
            button: AuthButton(
              hight: 50,
              radius: 14,
              width: double.infinity,
              text: 'Save Address',
              textColor: AppColors.white,
              function: () {
                if (formKey.currentState?.validate() ?? false) {
                  provider.updateAddress(index, address.id);
                  Navigator.pop(context);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
