import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/loading_pop.dart';
import 'package:coice/ui/common_widgets/resute_pop.dart';
import 'package:coice/ui/screens/auth/controller/controller.dart';
import 'package:coice/state/bloc/auth/auth_bloc/auth_bloc.dart';
import 'package:coice/state/bloc/auth/states/auth_state.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBlocListenerWidget extends StatelessWidget {
  const AuthBlocListenerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
       
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (_) => LoadingPopup(),
          );
        
          if (Navigator.canPop(context)) Navigator.pop(context);

       
        } else if (state is AuthSuccess || state is AuthError) {
          final s = state as dynamic;
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: AppColors.transparent,       
            builder: (_) => ResutePop(
              headText: s.message,
              buttonText: s.buttonText,
              normalColor: s.normalColor,
              subText: s.subText,
              icon: s.icon,
              transparentColor: s.transparentColor,
            
              onTap: _resolveNavigation(s),          
            ),
          );

        
        } else if (state is SocialAuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            _buildSnackBar(
              icon: state.icon,
              message: state.message,
              backgroundColor: state.backgroundColor,
              duration: state.duration,
            ),
          );
          AuthController.goToDashboard(context);       

        
        } else if (state is SocialAuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            _buildSnackBar(
              icon: state.icon,
              message: state.message,
              backgroundColor: state.backgroundColor,
              duration: state.duration,
              letterSpacing: 1,
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }



 
  void Function(BuildContext)? _resolveNavigation(dynamic state) {
    if (state.navigationRomoveUntil != null) {
     
      return (ctx) => Navigator.pushAndRemoveUntil(
            ctx,
            MaterialPageRoute(builder: (_) => state.navigationRomoveUntil!),
            (route) => false,
          );
    } else if (state.navigationReplace != null) {
     
      return (ctx) => Navigator.pushReplacement(
            ctx,
            MaterialPageRoute(builder: (_) => state.navigationReplace!),
          );
    } else if (state.navigation != null) {
     
      return (ctx) => Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => state.navigation!),
          );
    } else if (state.pop == true) {
      return (ctx) => Navigator.pop(ctx);
    }
    return null;
  }

  SnackBar _buildSnackBar({
    required IconData icon,
    required String message,
    required Color backgroundColor,
    required Duration duration,
    double letterSpacing = 0,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: AppColors.white),            
          const SizedBox(width: 12),
          Expanded(
            child: TextSlab(
              color: AppColors.white,
              letterSpacing: letterSpacing,
              text: message,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}





