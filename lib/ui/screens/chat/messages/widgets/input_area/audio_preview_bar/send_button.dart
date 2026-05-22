
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => IconButton(    
        onPressed: onTap,
        padding: EdgeInsets.zero,
        icon: Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: AppColors.white,                     
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_upward_rounded,
              size: 20,
              color: AppColors.black),
        ),
      );
}
