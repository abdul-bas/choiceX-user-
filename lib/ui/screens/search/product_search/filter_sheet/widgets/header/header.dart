import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/constants/ui_string/variant_color.dart';
import 'package:coice/core/constants/ui_string/variant_storage_opts.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildFilterHeader(BuildContext context) {
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E4EF),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: barndColor,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: barndColor.withValues(alpha: 0.30),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.tune_rounded,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filter Results',
                        style: TextStyle(
                          color: Color(0xFF0F1320),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        )),
                    SizedBox(height: 2),
                    Text('Narrow down what you need',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.read<FilterProvider>().clearFilters(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xFFE8EAF2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.refresh_rounded,
                          size: 14, color: Color(0xFF9CA3AF)),
                      SizedBox(width: 5),
                      Text('Reset',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Consumer<FilterProvider>(builder: (context, value, child) {
          final ci = value.colorIndex;
          final si = value.storageIndex;
          final budget = value.budgetRange;

          final hasColor = ci >= 0;
          final hasStorage = si >= 0;
          final hasBudget = budget?['min'] != 0 || budget?['max'] != 200000;

          final count =
              (hasColor ? 1 : 0) + (hasStorage ? 1 : 0) + (hasBudget ? 1 : 0);

          final activeList = [
            if (hasColor) variantColors[ci],
            if (hasStorage) variantStorageOpts[si],
            if (hasBudget && budget != null) budget['label'],
          ];

          if (activeList.isEmpty) {
            return Container(
              height: 30,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: barndColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: barndColor.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 13, color: barndColor.withValues(alpha: 0.60)),
                  const SizedBox(width: 5),
                  Text(
                    'No items available',
                    style: TextStyle(
                      color: barndColor.withValues(alpha: 0.70),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          return count > 0
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  decoration: BoxDecoration(
                    color: barndColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: barndColor.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.filter_alt_outlined,
                          size: 14, color: barndColor),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: activeList.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: barndColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                  )),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
              : Row(
                  children: const [
                    Icon(Icons.info_outline_rounded,
                        size: 14, color: Color(0xFFB0B4C8)),
                    SizedBox(width: 6),
                    Text(
                      'No filters selected yet',
                      style: TextStyle(
                        color: Color(0xFFB0B4C8),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                );
        }),
        SizedBox(
          height: 10,
        )
      ]));
}
