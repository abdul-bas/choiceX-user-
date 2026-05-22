
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/parsers/to_user_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/ui/screens/order_details/widgets/user_details_card/simple_info_row.dart';
import 'package:coice/core/utils/utils/snapshot_helper.dart';
import 'package:flutter/material.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthRepository().userData(),
      builder: (context, snapshot) {
        final result = handleSnapshot(snapshot);
        if (result != null) return result;

        final user = toUserModel(snapshot)!;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,          
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowDark,       
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 22),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'nick name',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'full address',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.grey700,       
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,          
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SimpleInfoRow(icon: Icons.person_outline, value: user.name),
                  SimpleInfoRow(icon: Icons.email_outlined, value: user.email),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],
        );
      },
    );
  }
}
