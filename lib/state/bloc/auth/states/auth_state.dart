import 'package:coice/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  final String buttonText;
  final String subText;
  final IconData icon;
  final Color normalColor;
  final Color transparentColor;
  final bool? pop;
  final Widget? navigationReplace;
  final Widget? navigationRomoveUntil;

  AuthSuccess({
    required this.message,
    this.buttonText = 'OK',
    this.subText = 'Operation successful',
    this.icon = Icons.check_circle,
    this.normalColor = Colors.green,
    this.transparentColor = const Color.fromARGB(60, 76, 175, 80),
    this.pop,this.navigationReplace,this.navigationRomoveUntil,

  });
}

class AuthError extends AuthState {
  final String message;
  final String buttonText;
  final String subText;
  final IconData icon;
  final Color normalColor;
  final Color transparentColor;
  final bool? pop;
  final Widget? navigation;
final Widget? navigationReplace;
  final Widget? navigationRomoveUntil;
  AuthError({
    required this.message,
    this.buttonText = 'Retry',
    this.subText = 'Something went wrong',
    this.icon = Icons.error,
    this.normalColor = Colors.red,
    this.transparentColor = const Color.fromARGB(60, 244, 67, 54),
    this.pop, this.navigation,this.navigationReplace,this.navigationRomoveUntil,
  });
}

class UserValidation extends AuthState {
  final bool exists;
  UserValidation(this.exists);
}

class AuthLogOutSuccess extends AuthState {
  final String message;
  AuthLogOutSuccess(this.message);
}

class AuthLogOutError extends AuthState {
  final String message;
  AuthLogOutError(this.message);
}

class SocialAuthSuccess extends AuthState {
  final UserModel user;
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Duration duration;

  SocialAuthSuccess({
    required this.user,
    this.message = 'Login successful',
    this.icon = Icons.check_circle,
    this.backgroundColor = Colors.green,
    this.duration = const Duration(seconds: 3),
  });
}

class SocialAuthError extends AuthState {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Duration duration;

  SocialAuthError({
    required this.message,
    this.icon = Icons.error_outline,
    this.backgroundColor = Colors.red,
    this.duration = const Duration(seconds: 3),
  });
}
class FavoriteSuccess extends AuthState {
  final String message;
  final String buttonText;
  final String subText;
  final IconData icon;
  final Color normalColor;
  final Color transparentColor;
  final bool? pop;
  final Widget? navigationReplace;
  final Widget? navigationRomoveUntil;

  FavoriteSuccess({
    required this.message,
    this.buttonText = 'OK',
    this.subText = 'Operation successful',
    this.icon = Icons.check_circle,
    this.normalColor = Colors.green,
    this.transparentColor = const Color.fromARGB(60, 76, 175, 80),
    this.pop,this.navigationReplace,this.navigationRomoveUntil,

  });
}



class FavoriteError extends AuthState {
  final String message;
  final String buttonText;
  final String subText;
  final IconData icon;
  final Color normalColor;
  final Color transparentColor;
  final bool? pop;
  final Widget? navigation;
final Widget? navigationReplace;
  final Widget? navigationRomoveUntil;
  FavoriteError({
    required this.message,
    this.buttonText = 'Retry',
    this.subText = 'Something went wrong',
    this.icon = Icons.error,
    this.normalColor = Colors.red,
    this.transparentColor = const Color.fromARGB(60, 244, 67, 54),
    this.pop, this.navigation,this.navigationReplace,this.navigationRomoveUntil,
  });
}


