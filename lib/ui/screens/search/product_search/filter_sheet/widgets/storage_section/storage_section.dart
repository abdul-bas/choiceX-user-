 import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/core/constants/ui_string/variant_storage_opts.dart';
import 'package:coice/state/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildStorageSection() {
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
          runSpacing: 10,
          children:
              List.generate(variantStorageOpts.length, (i) {
            final bool isSel = sel.storageIndex == i;
            return GestureDetector(
              onTap: () => sel.setStorage(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSel
                      ? barndColor
                      : const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSel
                        ? const Color(0xFF111827)
                        : const Color(0xFFE5E7EB),
                    width: isSel ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  variantStorageOpts[i],
                  style: TextStyle(
                    color: isSel
                        ? Colors.white
                        : const Color(0xFF111827),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }