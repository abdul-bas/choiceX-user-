 import 'package:flutter/material.dart';

Widget buildScrim() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.35, 0.70, 1.0],
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.45),
                Colors.black.withValues(alpha: 0.82),
              ],
            ),
          ),
        ),
      ),
    );
  }