

import 'package:coice/state/bloc/auth/states/auth_state.dart';

class EditProfileInitial extends AuthState {}

class EditProfileLoading extends AuthState {}

class EditProfileSuccess extends AuthState {}

class EditProfileFailure extends AuthState {
  final String error;

  EditProfileFailure({required this.error});
}
