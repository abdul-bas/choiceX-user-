import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/constants/app_strings/price_suggetions.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildBudgetSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Consumer<FilterProvider>(
        builder: (context, value, child) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: priceSuggestions.map((item) {
              final bool isSel =
                  value.budgetRange?['min'] == item['min'] &&
                      value.budgetRange?['max'] == item['max'];
              return GestureDetector(
                onTap: () => value.setBudget(item),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSel
                        ? barndColor
                        : const Color(0xFFF5F6FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSel
                          ? barndColor
                          : const Color(0xFFE5E7EB),
                      width: isSel ? 1.5 : 1,
                    ),
                    boxShadow: isSel
                        ? [
                            BoxShadow(
                              color: barndColor
                                  .withValues(alpha: 0.22),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    '${item['label']}',
                    style: TextStyle(
                      color: isSel
                          ? Colors.white
                          : const Color(0xFF111827),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }