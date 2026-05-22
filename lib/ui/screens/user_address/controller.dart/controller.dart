import 'package:coice/data/models/address_model.dart';
import 'package:flutter/material.dart';

class AddressController {
  static const List<String> addressTypes = [
    'Home',
    'Work',
    'Other',
  ];

  static IconData getAddressIcon(String nickName) {
    switch (nickName.toLowerCase()) {
      case 'home':
        return Icons.home_outlined;

      case 'work':
        return Icons.work_outline;

      default:
        return Icons.location_on_outlined;
    }
  }

  static String cap(String text) {
    if (text.isEmpty) return text;

    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

   String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a phone number';
    }

    if (value.trim().length < 10) {
      return 'Enter a valid phone number';
    }

    return null;
  }

   String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a location';
    }

    return null;
  }

   String? validateFullAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the full address';
    }

    if (value.trim().length < 10) {
      return 'Address must be at least 10 characters';
    }

    return null;
  }

   String? validateAddressType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select an address type';
    }

    return null;
  }

   AddressModel buildAddressModel({
    required String fullAddress,
    required String location,
    required String nickName,
    required String phoneNumber,
    required bool? providerIsDefault,
    bool forceDefault = false,
  }) {
    return AddressModel(
      id: '',
      fullAddress: fullAddress,
      isDefault: forceDefault ? true : (providerIsDefault ?? false),
      location: location,
      nickName: nickName,
      phoneNumber: phoneNumber,
    );
  }
  
void showAddressSnackBar(
  BuildContext context,
  String title,
  String subTitle,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subTitle),
        ],
      ),
    ),
  );
}
}
