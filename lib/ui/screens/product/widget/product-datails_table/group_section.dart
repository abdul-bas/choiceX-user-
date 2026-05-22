import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/screens/product/model/grop.dart';
import 'package:coice/ui/screens/product/widget/product-datails_table/spec_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupSection extends StatelessWidget {
  const GroupSection(
      {super.key, required this.group, required this.isLast});

  final Group group;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
          child: Row(
            children: [
              Icon(group.icon,
                  size: 13,
                  color: AppColors.textSecondary),   
              const SizedBox(width: 6),
              Text(
                group.title.toUpperCase(),
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,       
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors.specDivider,         
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
          child: Column(
            children:
                group.items.map((e) => SpecItemWidget(item: e)).toList(),
          ),
        ),
      ],
    );
  }
}
