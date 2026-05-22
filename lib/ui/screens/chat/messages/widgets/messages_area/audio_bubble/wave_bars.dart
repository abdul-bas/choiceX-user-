
import 'package:flutter/material.dart';

class WaveBarsSimple extends StatelessWidget {
  const WaveBarsSimple({
    super.key,
    required this.progress,
    required this.played,
    required this.dim,
    required this.animated,
    required this.heights,
  });

  final double progress;
  final Color played;
  final Color dim;
  final bool animated;
  final List<double> heights;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(heights.length, (i) {
        final frac = (i + 1) / heights.length;
        final isPlayed = frac <= progress;
        final height = heights[i] * 50;
        return AnimatedContainer(
          duration: animated
              ? const Duration(milliseconds: 300)
              : Duration.zero,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          width: 4,
          height: height,
          decoration: BoxDecoration(
            color: isPlayed ? played : dim,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

