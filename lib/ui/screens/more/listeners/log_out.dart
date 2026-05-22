import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/more/controller/profile_controller.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget logOutListener({
  required BuildContext context,
  required Widget child,
}) {
  return BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AuthLogOutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.success,      
          ),
        );
        ProfileController.goToWelcome(context);      
      } else if (state is AuthLogOutError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.danger,       
          ),
        );
      } else if (state is FavoriteSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.danger,        
          ),
        );
      } else if (state is FavoriteError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: state.normalColor,
          ),
        );
      }
    },
    child: child,
  );
}