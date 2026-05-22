
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget manageAddressEmpty(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(48),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 64,
          color: Color(0xFFCBD5E1),
        ),
        const SizedBox(height: 16),
        Text(
          'No addresses yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add your first delivery address to get started',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {
            // pushFuction(AddAddressScreen(), context);
          },
          icon: const Icon(Icons.add, size: 20),
          label: const Text('Add Address'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brand,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}