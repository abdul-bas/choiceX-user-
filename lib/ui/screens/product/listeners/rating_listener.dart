import 'package:coice/ui/common_widgets/loading_pop.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';


import 'package:coice/state/bloc/auth/states/rating_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ratingListener({required Widget child}) {
  return BlocListener<AuthBloc, AuthState>(
    listener: (context, state) {
      if (state is RatingLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const LoadingPopup(),
        );
      }

      if (state is RatingUpdated) {
         
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message )),
        );
      }
    },
    child: child,
  );
}


