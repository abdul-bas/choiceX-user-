import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/utils/helpers/common/address_icons.dart';
import 'package:coice/data/models/address_model.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/address_map_thumbnail.dart';
import 'package:coice/ui/screens/order_summery/widgets/address_section/default_badge.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

Widget buildAddressCard(AddressModel address) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          buildAddressMapThumbnail(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      getAddressIcon(address.nickName),
                      size: 16,
                      color: barndColor,
                    ),
                    const SizedBox(width: 6),
                    TextInter(
                      text: address.nickName,
                      letterSpacing: 0.5,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(width: 6),
                    buildDefaultBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                TextInter(
                  text: address.fullAddress,
                  overFlow: TextOverflow.ellipsis,
                  maxLines: 3,
                  letterSpacing: 0.3,
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }