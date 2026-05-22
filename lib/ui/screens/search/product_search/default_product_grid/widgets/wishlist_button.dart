import 'package:flutter/material.dart';

Widget buildWishlistButton() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.20),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
          ),
        ),
        child: const Icon(
          Icons.favorite_border_rounded,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }