
import 'package:choicex/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:choicex/state/bloc/auth/events/auth_event.dart';
import 'package:choicex/state/bloc/auth/states/auth_state.dart';
import 'package:choicex/ui/screens/user_dashboard/DashboardScreen.dart';
import 'package:choicex/ui/screens/welcom_screen/welcome_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocAuthDispatcher extends StatelessWidget {
  const BlocAuthDispatcher({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(Authentication());
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
       
        await Future.delayed(Duration(seconds: 3));

        if (state is UserValidation && state.exists) {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => DashboardScreen()),
          );
        } else if (state is UserValidation && !state.exists) {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => WelcomeScreen()),
          );
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
