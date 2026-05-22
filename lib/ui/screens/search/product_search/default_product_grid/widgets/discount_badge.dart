 import 'package:flutter/material.dart';

Widget buildDiscountBadge(int discount) {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3D3D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '-$discount%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }