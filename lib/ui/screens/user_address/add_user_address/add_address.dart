import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/address_event.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/user_address/controller.dart/controller.dart';
import 'package:coice/ui/screens/user_address/listeners/address_listener.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/addresss_form_section.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({
    super.key,
    required this.navigation,
    this.isDefault,
  });

  final VoidCallback navigation;
  final bool? isDefault;

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AddressProvider provider;
final AddressController _controller = AddressController();

  @override
  void initState() {
    provider = context.read<AddressProvider>();
    provider.clearForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return addressListener(
      controller: _controller,
      navigation: widget.navigation,
      child: AddressFormSection(
        label: 'Set',
        isDefault: widget.isDefault,
        addressTypeController: provider.addressTypeController,
        locationController: provider.locationController,
        fullAddressController: provider.fullAddressController,
        phoneNumberController: provider.phoneNumberController,
        formKey: formKey,
        button: AuthButton(
          hight: 52,
          radius: 14,
          width: double.infinity,
          text: 'Save Address',
          textColor: AppColors.white,
          function: () {
            if (formKey.currentState!.validate()) {
              final address = _controller. buildAddressModel(
                fullAddress: provider.fullAddressController.text.trim(),
                location: provider.locationController.text.trim(),
                nickName: provider.addressTypeController.text.trim(),
                phoneNumber: provider.phoneNumberController.text.trim(),
                providerIsDefault: provider.isDefault,
                forceDefault: widget.isDefault == null,
              );
              context.read<AuthBloc>().add(AddAddressEvent(addressModel: address));
              context.read<AddressProvider>().addAddress(address);
            }
          },
        ),
      ),
    );
  }
}
