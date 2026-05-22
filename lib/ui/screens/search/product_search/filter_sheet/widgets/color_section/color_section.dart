
  import 'package:coice/core/constants/ui_string/variant_color.dart';
import 'package:coice/core/constants/ui_string/variant_colors_map.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildColorSection() {
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
        builder: (_, sel, __) => Wrap(
          spacing: 12,
          runSpacing: 14,
          children: List.generate(variantColors.length, (i) {
            final bool isSel = sel.colorIndex == i;
            final Color swatch =
                variantColorMap[variantColors[i]] ?? Colors.grey;
            return GestureDetector(
              onTap: () => sel.setColor(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 35,
                    height: 30,
                    decoration: BoxDecoration(
                      color: swatch,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSel
                            ? const Color(0xFF111827)
                            : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: swatch.withValues(
                              alpha: isSel ? 0.45 : 0.18),
                          blurRadius: isSel ? 14 : 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: isSel
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 18)
                        : null,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    variantColors[i],
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: isSel
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: isSel
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }