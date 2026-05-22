import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/address_state.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/ui/screens/user_address/controller.dart/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget addressListener({
  required Widget child,
  required VoidCallback navigation,
  required AddressController controller

}) {
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is AddAddressSuccess || state is AddressUpdateSuccess) {
       controller. showAddressSnackBar(context, 'Success', 'Address saved successfully');
        WidgetsBinding.instance.addPostFrameCallback((_) => navigation());
      } else if (state is AddAddressError || state is AddressUpdateError) {
        controller. showAddressSnackBar(
            context, 'Error', 'Something went wrong. Please try again.');
      }
    },
    builder: (context, state) {
      return Stack(
        children: [
          child,
          if (state is AuthLoading)
            Container(
              color: AppColors.overlayBarrier,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
        ],
      );
    },
  );
}
