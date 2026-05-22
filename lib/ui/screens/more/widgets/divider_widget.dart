import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildDivider() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Divider(
      height: 0,
      thickness: 1,
      color: AppColors.grey100,                       
    ),
  );
}
