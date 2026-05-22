 import 'dart:typed_data';

import 'package:coice/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildFullBleedImage(Uint8List bytes) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: const Color(0xFFEEF0F6),
            child: Icon(
              Icons.image_not_supported_outlined,
              color: barndColor.withValues(alpha: 0.2),
              size: 32,
            ),
          ),
        ),
      ),
    );
  }