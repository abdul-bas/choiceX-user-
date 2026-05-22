
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class StatusConfig {
  final Color color;
  final Color darkShade;
  final IconData icon;
  final IconData infoIcon;
  final String headline;
  final String subline;
  final String infoText;
  final String statusKey;

  const StatusConfig({
    required this.color,
    required this.darkShade,
    required this.icon,
    required this.infoIcon,
    required this.headline,
    required this.subline,
    required this.infoText,
    required this.statusKey,
  });

  factory StatusConfig.from(String status) {
    switch (status.trim().toLowerCase()) {
      case 'pending':
        return StatusConfig(
          color: Colors.orange,
          darkShade: Colors.orange.shade800,
          icon: Icons.hourglass_top_rounded,
          infoIcon: Icons.schedule_rounded,
          headline: 'Return Request Received',
          subline: 'Your return request is queued and\nwaiting to be assigned.',
          infoText:
              'We\'ll notify you once our team picks up your request. This usually takes 1–2 business hours.',
          statusKey: 'Pending',
        );
      case 'under review':
        return StatusConfig(
          color: const Color(0xFF2196F3),
          darkShade: const Color(0xFF1565C0),
          icon: Icons.manage_search_rounded,
          infoIcon: Icons.inventory_2_outlined,
          headline: 'Reviewing Your Return',
          subline:
              'Our team is inspecting the return details\nand verifying eligibility.',
          infoText:
              'Please ensure the item is packed securely. You may be contacted for additional photos or details.',
          statusKey: 'Under Review',
        );
      case 'approved':
        return StatusConfig(
          color: const Color(0xFF00ACC1),
          darkShade: const Color(0xFF006064),
          icon: Icons.verified_rounded,
          infoIcon: Icons.local_shipping_outlined,
          headline: 'Return Approved!',
          subline:
              'Great news — your return has been\napproved and is being processed.',
          infoText:
              'Pack the item as instructed and hand it to the courier. Your refund will be initiated once we receive it.',
          statusKey: 'Approved',
        );
      case 'refunded':
        return StatusConfig(
          color: const Color(0xFF43A047),
          darkShade: const Color(0xFF1B5E20),
          icon: Icons.price_check_rounded,
          infoIcon: Icons.account_balance_wallet_outlined,
          headline: 'Refund Successful!',
          subline:
              'Your refund has been processed and\nis on its way to your account.',
          infoText:
              'Funds typically reflect in 3–5 business days depending on your payment method.',
          statusKey: 'Refunded',
        );
      case 'rejected':
        return StatusConfig(
          color: const Color(0xFFE53935),
          darkShade: const Color(0xFFB71C1C),
          icon: Icons.cancel_rounded,
          infoIcon: Icons.support_agent_rounded,
          headline: 'Return Rejected',
          subline:
              'Unfortunately your return request\ncould not be approved this time.',
          infoText:
              'If you believe this is an error, please contact our support team with your order ID for further assistance.',
          statusKey: 'Rejected',
        );
      default:
        return StatusConfig(
          color: AppColors.brand,
          darkShade: AppColors.brand.withOpacity(0.8),
          icon: Icons.info_outline_rounded,
          infoIcon: Icons.info_outline_rounded,
          headline: 'Status Updated',
          subline: 'Your return request status\nhas been updated.',
          infoText: 'Check your order history for the latest details.',
          statusKey: '',
        );
    }
  }
}
