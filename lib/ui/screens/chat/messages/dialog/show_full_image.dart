
import 'dart:convert';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

void showFullImage(BuildContext context, String base64) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: AppColors.black,              
      child: InteractiveViewer(
        child: Image.memory(base64Decode(base64)),
      ),
    ),
  );
}