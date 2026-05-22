import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/provider/address_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget showDeleteAddressDialog(BuildContext context, int index) {
  return Dialog(
    backgroundColor: AppColors.transparent,
    insetPadding: const EdgeInsets.symmetric(horizontal: 28),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDialog,
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 32, bottom: 20),
            decoration: BoxDecoration(
              color: AppColors.dangerLight,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.dangerSubtle,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.dangerBorder,
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.danger,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
            child: Column(
              children: [
                Text(
                  'Delete Address?',
                  style: TextStyle(
                    color: AppColors.addressHeading,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This address will be permanently removed from your saved locations.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.addressSubtext,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Row(
              children: [
                // Cancel
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.addressSheetBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.addressBorder),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.addressSubtext,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Delete
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<AddressProvider>().deleteAddress(index);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.danger.withValues(alpha: 0.30),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline_rounded,
                              color: AppColors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Delete',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
