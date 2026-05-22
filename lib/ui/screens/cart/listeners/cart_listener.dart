import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/state/bloc/auth/states/cart_state.dart';
import 'package:coice/ui/common_widgets/loading_pop.dart';
import 'package:coice/ui/common_widgets/resute_pop.dart';
import 'package:coice/ui/screens/cart/contorller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Widget addCartListener({required Widget child}) {
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is CartSuccessfullyAdded) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => ResutePop(
            headText: 'Item Added to Cart!',
            subText: 'Your product has been successfully added.',
            buttonText: 'Go to Cart',
            normalColor: AppColors.success,         
            transparentColor: AppColors.successSubtle, 
            icon: Icons.shopping_cart_checkout,
            onTap: CartController.goToCart,           
            image: 'assets/images/baground_remove_cart.png',
          ),
        );
      }
    },

    builder: (context, state) {
      return Stack(
        children: [
          child,

          if (state is CartLoading)
            
           Scaffold(
            backgroundColor: AppColors.transparent,
            body: LoadingPopup())
        ],
      );
    },
  );
}