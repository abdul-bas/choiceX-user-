import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/more/controller/profile_controller.dart';
import 'package:flutter/material.dart';
class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log Out?'),
      content: const Text(
        'Are you sure you want to log out of your account? You will need to sign in again to access your features.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Stay Signed In'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.danger,          
            foregroundColor: AppColors.white,           
          ),
          onPressed: () => ProfileController.logout(context), 
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}
