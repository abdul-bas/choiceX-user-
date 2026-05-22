import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/data/repository/auth_repository.dart';

import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController addressTypeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fullAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool? isDefault;

  int? _defaultIndex;
  AddressModel? _defaultAddress;

  final String userId = AuthRepository().getUeserId();

  final List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => List.unmodifiable(_addresses);

  AddressModel? get defaultAddress => _defaultAddress;

  int? get defaultIndex => _defaultIndex;

  void clearForm() {
    addressTypeController.clear();
    locationController.clear();
    fullAddressController.clear();
    phoneNumberController.clear();
    isDefault = false;
  }

  @override
  void dispose() {
    addressTypeController.dispose();
    locationController.dispose();
    fullAddressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void toggleStatus() {
    isDefault = !(isDefault ?? false);
    notifyListeners();
  }

  void loadAddress(AddressModel address) {
    addressTypeController.text = address.nickName;
    locationController.text = address.location;
    fullAddressController.text = address.fullAddress;
    phoneNumberController.text = address.phoneNumber;
    isDefault = address.isDefault;
    notifyListeners();
  }

  Future<void> getAddress() async {
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('userAddress')
          .doc(userId)
          .collection('addresses')
          .get();

      _addresses.clear();

      int i = -1;

      _addresses.addAll(
        snapshot.docs.map((e) {
          i++;

          final model = AddressModel.fromMap(e.data());

          if (model.isDefault) {
            _defaultAddress = model;
            _defaultIndex = i;
          }

          return model;
        }).toList(),
      );
    } finally {
      notifyListeners();
    }
  }

  addAddress(AddressModel address) {
    _addresses.add(address);

    if (_defaultAddress == null && _defaultIndex == null) {
      for (int i = 0; i < _addresses.length; i++) {
        if (_addresses[i].isDefault) {
          _defaultAddress = _addresses[i];
          _defaultIndex = i;
          break;
        }
      }
    }
    notifyListeners();
  }

  Future<void> toggleDefault(int index) async {
    _isLoading = true;
    notifyListeners();

    try {
      final selectedAddress = _addresses[index];
      final currentDefaultAddress = _defaultAddress;
      final currentDefaultIndex = _defaultIndex;

      if (currentDefaultAddress != null) {
        await _firestore
            .collection('userAddress')
            .doc(userId)
            .collection('addresses')
            .doc(currentDefaultAddress.id)
            .set({'IsDefault': false}, SetOptions(merge: true));
      }

      await _firestore
          .collection('userAddress')
          .doc(userId)
          .collection('addresses')
          .doc(selectedAddress.id)
          .set({'IsDefault': true}, SetOptions(merge: true));

      if (currentDefaultIndex != null &&
          currentDefaultIndex >= 0 &&
          currentDefaultIndex < _addresses.length) {
        _addresses[currentDefaultIndex].isDefault = false;
      }

      _addresses[index].isDefault = true;

      _defaultAddress = _addresses[index];
      _defaultIndex = index;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress(int index, String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userId = AuthRepository().getUeserId();

      if (isDefault == true) {
        final currentDefaultAddress = _defaultAddress;
        final currentDefaultIndex = _defaultIndex;

        if (currentDefaultAddress != null) {
          await _firestore
              .collection('userAddress')
              .doc(userId)
              .collection('addresses')
              .doc(currentDefaultAddress.id)
              .set({'IsDefault': false}, SetOptions(merge: true));
        }

        if (currentDefaultIndex != null) {
          _addresses[currentDefaultIndex].isDefault = false;
        }

        _addresses[index].isDefault = true;

        _defaultAddress = _addresses[index];
        _defaultIndex = index;
      }

      AddressModel newAddress = AddressModel(
        id: id,
        nickName: addressTypeController.text.trim(),
        location: locationController.text.trim(),
        fullAddress: fullAddressController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        isDefault: isDefault ?? false,
      );

      await _firestore
          .collection('userAddress')
          .doc(userId)
          .collection('addresses')
          .doc(id)
          .update(newAddress.toMap());

      _addresses[index] = newAddress;

      if (newAddress.isDefault) {
        _defaultAddress = newAddress;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAddress(int index) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (index == _defaultIndex) {
        final len = _addresses.length;

        if (_defaultIndex! < len - 1) {
          _defaultIndex = _defaultIndex! + 1;
        } else if (_defaultIndex! > 0) {
          _defaultIndex = _defaultIndex! - 1;
        } else {
          _defaultIndex = null;
          _defaultAddress = null;
        }

        if (_defaultIndex != null) {
          _defaultAddress = _addresses[_defaultIndex!];

          await _firestore
              .collection('userAddress')
              .doc(userId)
              .collection('addresses')
              .doc(_defaultAddress!.id)
              .set({'IsDefault': true}, SetOptions(merge: true));
        }
      }

      final address = _addresses[index];

      await _firestore
          .collection('userAddress')
          .doc(userId)
          .collection('addresses')
          .doc(address.id)
          .delete();

      _addresses.removeAt(index);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
