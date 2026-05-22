import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/user_model.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';
import 'package:coice/ui/screens/auth/forgot_password.dart';
import 'package:coice/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthController {
  AuthController._();

  
  static void applyLightSystemUI() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.surfaceWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  

  static void signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    context.read<AuthBloc>().add(SignIn(email: email, password: password));
  }

  

  static void signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) {
    final model = UserModel(
      name: name,
      email: email,
      password: password,
      createdAt: DateTime.now(),
    );
    context.read<AuthBloc>().add(SignUp(model: model));
  }

  

  static void sendPasswordReset({
    required BuildContext context,
    required String email,
  }) {
    context.read<AuthBloc>().add(EmailPassword(email: email));
 
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

 

  static void signInWithGoogle(BuildContext context) {
    context.read<AuthBloc>().add(GoogleSignInEvent());
  }

  static void signInWithFacebook(BuildContext context) {
    context.read<AuthBloc>().add(FacebookSignInEvent());
  }

 

  static void goToDashboard(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => DashboardScreen()),
      (route) => false,
    );
  }

  static void showForgotPassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => const ForgetPassWordScreen(),
    );
  }

  

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}