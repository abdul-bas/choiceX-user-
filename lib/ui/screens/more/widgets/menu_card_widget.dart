import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';


Widget buildMenuCard({required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,                
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDark,            
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(children: children),
    ),
  );
}