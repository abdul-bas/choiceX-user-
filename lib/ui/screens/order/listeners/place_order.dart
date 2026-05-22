import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/check_out_success.dart';
import 'package:coice/ui/screens/order/controller/controller.dart';
import 'package:coice/ui/common_widgets/loading_pop.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget placeOrderListener({required Widget child}) {
  return BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is OrdersLoadingState) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LoadingPopup(),
        );
      } else if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      if (state is OrdersErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.danger,             
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Retry',
              textColor: AppColors.white,                 
              onPressed: () => Navigator.pop(context),
            ),
          ),
        );
      }

      if (state is OrdersSuccessState) {
        OrderController.goToOrdersAfterPlacing(context);   

        WidgetsBinding.instance.addPostFrameCallback(
          (_) async => OrderController.clearCart(),        
        );

        showModalBottomSheet(
          context: context,
          builder: (_) => checkOutSuccessPop(
            onPressed: () => Navigator.pop(context),
            buttonText: 'Continue',
            image: 'assets/images/OIP-removebg-preview.png',
            subText: 'Order placed successfully',
          ),
        );
      }
    },
    child: child,
  );
}