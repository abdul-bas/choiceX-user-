
  import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


class TrackingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrackingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.surfaceWhite,      
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black87,                
          size: 20,
        ),
      ),
      title: const Text(
        'Track Order',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.black87,                 
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
            color: AppColors.grey700,                
          ),
        ),
      ],
    );
  }
}