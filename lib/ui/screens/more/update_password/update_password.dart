import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/auth/controller/controller.dart';
import 'package:coice/ui/screens/more/controller/profile_controller.dart';
import 'package:coice/ui/screens/more/listeners/update_password_listeners.dart';
import 'package:coice/ui/common_widgets/custom_text_button.dart';
import 'package:coice/ui/common_widgets/cutom_text_form_field_with_label.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextSlab(
          text: 'Change Password',
          letterSpacing: 0.3,
          fontSize: 20,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: changePasswordBlocListener(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.brandSubtle.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 60,
                      color: AppColors.brand.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.brandSubtle.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.brand.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Choose a strong password to keep your account secure',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.black45,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                AuthTextFeild(
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
                  text: 'Enter Current Password',
                  validator: ProfileController.validateCurrentPassword,
                ),
                AuthTextFeild(
                  textType: TextInputType.number,
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  text: 'Enter New Password',
                  validator: (value) => ProfileController.validateNewPassword(
                    value,
                    _currentPasswordController.text,
                  ),
                ),
                AuthTextFeild(
                  textType: TextInputType.number,
                  controller: _confirmPasswordController,
                  hintText: 'Confirm New Password',
                  text: 'Enter Confirm New Password',
                  validator: (value) =>
                      ProfileController.validateConfirmPassword(
                    value,
                    _newPasswordController.text,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: AuthButton(
                    hight: 50,
                    width: double.infinity,
                    text: 'Change Password',
                    textColor: AppColors.white,
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        ProfileController.updatePassword(
                          // ← controller
                          context: context,
                          currentPassword:
                              _currentPasswordController.text.trim(),
                          newPassword: _newPasswordController.text.trim(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () => AuthController.showForgotPassword(context),
                    child: TextInter(
                      text: 'Forgot your current password?',
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.brand,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
