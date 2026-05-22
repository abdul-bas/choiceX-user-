
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/user_address/controller.dart/controller.dart';
import 'package:flutter/material.dart';


class AddressTypeDropdown extends StatelessWidget {
  const AddressTypeDropdown({
    super.key,
    required this.items,
    required this.controller,
  });

  final List<String> items;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      hint: const Text(
        'Select address type',
        style: TextStyle(fontSize: 14, color: AppColors.textHint),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: AppColors.textCoolGrey),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_city_outlined,
            size: 20, color: AppColors.textCoolGrey),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: AppColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderCategory),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderCategory),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.brandSubtle, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.danger),
      ),
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textNavy,
        fontWeight: FontWeight.w400,
      ),
      validator: AddressController().
 validateAddressType,
      onChanged: (value) => controller.text = value ?? '',
      items: items
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
    );
  }
}