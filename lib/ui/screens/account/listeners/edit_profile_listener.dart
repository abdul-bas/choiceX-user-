import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBlocListener extends StatelessWidget {
  const EditProfileBlocListener({super.key, required this.child});

  final Widget child;

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _dismissDialog(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EditProfileLoading) {
          _showLoadingDialog(context);
        }
        if (state is EditProfileSuccess) {
          _dismissDialog(context);
          _showSnackBar(
              context, 'Profile updated successfully', AppColors.success);
          Navigator.pop(context);
        }
        if (state is EditProfileFailure) {
          _dismissDialog(context);
          print('\n${state.error}/n////////////////////////////////////////////////////////////////////////////////////////////////');
          _showSnackBar(context, state.error, AppColors.danger);
        }
      },
      child: child,
    );
  }
}
