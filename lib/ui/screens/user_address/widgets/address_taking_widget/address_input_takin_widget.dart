
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/address_state.dart';
import 'package:coice/ui/screens/user_address/controller.dart/controller.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/address_type_drop_down.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/checkout_header.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/field_label.dart';
import 'package:coice/ui/screens/user_address/widgets/address_taking_widget/styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressInputTakinWidget extends StatelessWidget {
   AddressInputTakinWidget({
    super.key,
    required this.globalKey,
    required this.addressTypes,
    required this.addressTypeController,
    required this.phoneNumberController,
    required this.locationController,
    required this.fullAddressController,
    required this.button,
    this.scrollController,
    this.text,
    this.isDefault,
  });

  final GlobalKey<FormState> globalKey;
  final List<String> addressTypes;
  final TextEditingController addressTypeController;
  final TextEditingController phoneNumberController;
  final TextEditingController locationController;
  final TextEditingController fullAddressController;
  final ScrollController? scrollController;
  final String? text;
  final Widget button;
  final bool? isDefault;
  final AddressController _controller = AddressController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: text != null
                  ? Text(
                      text!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: AppColors.textNavy,
                      ),
                    )
                  : const AddressCheckoutHeader(),
            ),
            const SizedBox(height: 35),
            const AddressFieldLabel(label: 'Address Nickname'),
            const SizedBox(height: 8),
            AddressTypeDropdown(
              items: addressTypes,
              controller: addressTypeController,
            ),
            const SizedBox(height: 14),
            const AddressFieldLabel(label: 'Phone Number'),
            const SizedBox(height: 8),
            StyledTextField(
              textInputAction: TextInputAction.next,
              controller: phoneNumberController,
              hintText: 'Enter phone number',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator:_controller. validatePhone,
            ),
            const SizedBox(height: 14),
            const AddressFieldLabel(label: 'Location'),
            const SizedBox(height: 8),
            StyledTextField(
              textInputAction: TextInputAction.next,
              controller: locationController,
              hintText: 'Enter your location',
              prefixIcon: Icons.location_on_outlined,
              validator: _controller.validateLocation,
            ),
            const SizedBox(height: 14),
            const AddressFieldLabel(label: 'Full Address'),
            const SizedBox(height: 8),
            StyledTextField(
              textInputAction: TextInputAction.done,
              controller: fullAddressController,
              hintText: 'Street, area, city…',
              maxLines: null,
              validator:_controller. validateFullAddress,
            ),
            const SizedBox(height: 20),
            if (isDefault != null)
              GestureDetector(
                onTap: () => context.read<AddressProvider>().toggleStatus(),
                child: Consumer<AddressProvider>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: value.isDefault!
                                ? AppColors.brand
                                : AppColors.surfaceWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: value.isDefault!
                                  ? AppColors.brandSubtle
                                  : AppColors.addressBorder,
                              width: 1.5,
                            ),
                          ),
                          child: value.isDefault!
                              ? const Icon(Icons.check,
                                  size: 15, color: AppColors.white)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        const Text('Set as default address'),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: button),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
