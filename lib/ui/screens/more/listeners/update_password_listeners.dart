import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/update_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget changePasswordBlocListener({required Widget child}) {
  return BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is ChangePasswordLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      }

      if (state is ChangePasswordSuccess) {
        if (Navigator.canPop(context)) Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }

      if (state is ChangePasswordFailure) {
        if (Navigator.canPop(context)) Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    },
    child: child,
  );
}
