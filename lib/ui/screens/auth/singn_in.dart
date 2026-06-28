import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/auth/controller/controller.dart';
import 'package:coice/ui/screens/auth/listeners/auth_bloc_listener.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_bloc.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_event.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_state.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_robo_mono.dart';
import 'package:coice/ui/common_widgets/cutom_text_form_field_with_label.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {             
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthController.applyLightSystemUI();             
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 13),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextRobotoMono(text: 'Login Account', fontSize: 28),
                  const SizedBox(height: 5),

                  Opacity(
                    opacity: 0.3,
                    child: TextInter(
                      text: 'Please login with registered account',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: SizedBox(
                      width: width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextFeild(
                            validator: AuthController.validateEmail,  
                            controller: _email,
                            text: 'Enter your Email',
                            hintText: 'Email',
                            frontIcon: const Icon(Icons.email),
                          ),
                          BlocBuilder<ObscureBloc, ObscureTextState>(
                            builder: (context, state) {
                              final obscure =
                                  state is TextObs ? state.obscue2 : true;
                              return AuthTextFeild(
                                validator: AuthController.validatePassword, 
                                controller: _password,
                                text: 'Enter your password',
                                textType: TextInputType.number,
                                frontIcon: const Icon(Icons.lock),
                                sufixIcon: obscure,
                                obs: obscure,
                                obscure: obscure,
                                function: () => context
                                    .read<ObscureBloc>()
                                    .add(Value2Change()),
                              );
                            },
                          ),

                
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  AuthController.showForgotPassword(context), 
                              child: TextInter(
                                text: 'Forgot Password?',
                                color: AppColors.brand,  
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),

                  AuthButton(
                    width: width,
                    text: 'Login',                       
                    textColor: AppColors.white,         
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController.signIn(           
                          context: context,
                          email: _email.text.trim(),
                          password: _password.text.trim(),
                        );
                      }
                    },
                  ),

                  SizedBox(
                    height: 40,
                    width: width,
                    child: Center(
                      child: Opacity(
                        opacity: 0.3,
                        child: TextInter(
                          letterSpacing: 0.5,
                          text: 'Or using other method',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  AuthButton(
                    width: width,
                    color: AppColors.surfaceWhite,     
                    text: 'Sign Up With Google',       
                    function: () =>
                        AuthController.signInWithGoogle(context), 
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: AppColors.googleIcon,      
                      size: 25,
                    ),
                  ),
                  const SizedBox(height: 17),

                  AuthButton(
                    width: width,
                    color: AppColors.surfaceWhite,      
                    text: 'Sign Up With Facebook',
                    function: () =>
                        AuthController.signInWithFacebook(context), 
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: AppColors.facebookBlue,   
                      size: 25,
                    ),
                  ),

                  const AuthBlocListenerWidget(),        
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}