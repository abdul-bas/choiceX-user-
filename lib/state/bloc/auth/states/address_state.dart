import 'package:coice/state/bloc/auth/states/auth_state.dart';

class AddAddressSuccess extends AuthState {
  String title;
  String subTitle;
  AddAddressSuccess({required this.subTitle, required this.title});
}class AddressUpdateSuccess extends AuthState {}

class AddressUpdateError extends AuthState {
  final String message;

  AddressUpdateError(this.message);
}
class AddAddressError extends AuthState {
  String title;
  String subTitle;
  AddAddressError({required this.subTitle, required this.title});
}
