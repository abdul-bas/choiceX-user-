import 'package:coice/data/models/address_model.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';

class AddAddressEvent extends AuthEvent {
  final AddressModel addressModel;

  AddAddressEvent(
      {required this.addressModel});
}

class UpdateAddress extends AuthEvent {
  final int index;
  final String nickName;
  final String location;
  final String fullAddress;
  final bool isDefault;
  final String phoneNumber;

  UpdateAddress(
      {required this.index,
      required this.nickName,
      required this.location,
      required this.fullAddress,
      required this.isDefault,
      required this.phoneNumber});
}

class DeleteExistingAddress extends AuthEvent {
  final int index;

  DeleteExistingAddress({
    required this.index,
  });
}
