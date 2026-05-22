

import 'package:coice/state/bloc/auth/states/auth_state.dart';

class ChangePasswordInitial extends AuthState {}

class ChangePasswordLoading extends AuthState {}

class ChangePasswordSuccess extends AuthState {}

class ChangePasswordFailure extends AuthState {
  final String error;

  ChangePasswordFailure({required this.error});
}
