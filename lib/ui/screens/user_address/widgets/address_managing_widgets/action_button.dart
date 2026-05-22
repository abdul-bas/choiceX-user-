
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/user_address/add_user_address/add_address.dart';
import 'package:flutter/material.dart';

Widget buildFAB(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
      20,
      0,
      20,
      MediaQuery.of(context).padding.bottom + 12,
    ),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AddAddress(
            isDefault: false,
            navigation: () => Navigator.pop(context),
          ),
        ),
      ),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.brand,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowBrand,
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location_alt_rounded,
                color: AppColors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Add New Address',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}