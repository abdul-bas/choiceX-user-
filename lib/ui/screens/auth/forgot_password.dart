

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/cutom_text_form_field_with_label.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:coice/ui/screens/auth/controller/controller.dart';
import 'package:flutter/material.dart';

class ForgetPassWordScreen extends StatefulWidget {      
  const ForgetPassWordScreen({super.key});

  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();                          
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.surfaceWhite,               
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 3.5,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.textMuted,    
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                   TextSlab(text: 'Forgot Password', fontSize: 27),
                  const SizedBox(height: 10),

                  Opacity(
                    opacity: 0.3,
                    child: TextInter(
                      text: 'Enter your mail or phone number',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: AuthTextFeild(
                      controller: _emailController,
                      validator: AuthController.validateEmail,
                      text: 'Enter your Email',
                      hintText: 'Email',
                      frontIcon: const Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(height: 30),

                  AuthButton(
                    width: width,
                    text: 'Send Mail',
                    textColor: AppColors.white,        
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        AuthController.sendPasswordReset(
                          context: context,
                          email: _emailController.text.trim(),
                        );                             
                        _emailController.clear();
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}