import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_bloc.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_event.dart';
import 'package:coice/state/bloc/obscure_bloc/obscure_state.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/cutom_text_form_field_with_label.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_robo_mono.dart';
import 'package:coice/ui/screens/auth/controller/controller.dart';
import 'package:coice/ui/screens/auth/listeners/auth_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {              
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AuthController.applyLightSystemUI();                 
  }

  @override
  void dispose() {
    _name.dispose();
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
                  const TextRobotoMono(text: 'Create Account', fontSize: 28),
                  const SizedBox(height: 5),

                  Opacity(
                    opacity: 0.3,
                    child: TextInter(
                      text: 'Start exploring - create your account now',
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
                            validator: AuthController.validateName,  
                            text: 'Enter your name',
                            hintText: 'Name',
                            controller: _name,
                            frontIcon: const Icon(Icons.person),
                          ),
                          AuthTextFeild(
                            validator: AuthController.validateEmail,  
                            text: 'Enter your Email',
                            hintText: 'Email',
                            controller: _email,
                            frontIcon: const Icon(Icons.email),
                          ),
                          BlocBuilder<ObscureBloc, ObscureTextState>(
                            builder: (context, state) {
                              final obscure =
                                  state is TextObs ? state.obscure : true;
                              return AuthTextFeild(
                                validator: AuthController.validatePassword, 
                                text: 'Enter your password',
                                controller: _password,
                                textType: TextInputType.number,
                                frontIcon: const Icon(Icons.lock),
                                sufixIcon: obscure,
                                obs: obscure,
                                obscure: obscure,
                                function: () => context
                                    .read<ObscureBloc>()
                                    .add(Value1Change()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),

                  AuthButton(
                    width: width,
                    text: 'Create Account',
                    textColor: AppColors.white,         
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController.signUp(           
                          context: context,
                          name: _name.text.trim(),
                          email: _email.text.trim(),
                          password: _password.text.trim(),
                        );
                        _name.clear();
                        _email.clear();
                        _password.clear();
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
                  const SizedBox(height: 20),

                  AuthButton(
                    width: width,
                    color: AppColors.surfaceWhite,       
                    text: 'Sign In With Google',        
                    function: () =>
                        AuthController.signInWithGoogle(context), 
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: AppColors.googleIcon,      
                      size: 25,
                    ),
                  ),
                  const SizedBox(height: 17),

                  AuthButton(
                    width: width,
                    color: AppColors.surfaceWhite,       
                    text: 'Sign In With Facebook',
                    function: () =>
                        AuthController.signInWithFacebook(context),
                    icon: Icon(
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
