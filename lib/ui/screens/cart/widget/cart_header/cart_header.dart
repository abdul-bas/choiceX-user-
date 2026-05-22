import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';
 PreferredSizeWidget buildCartHeader(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: AppColors.surfaceWhite, 
      title: TextSlab(
        text: 'My Cart',
        fontSize: 20,
        letterSpacing: 0.3,
      ),
      centerTitle: true,
    );
  }
