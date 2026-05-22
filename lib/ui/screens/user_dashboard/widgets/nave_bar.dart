

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
class DashboardNavBar extends StatelessWidget {
  const DashboardNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.surfaceWhite,
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.textMuted,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz, size: 30),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}