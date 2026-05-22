 import 'dart:ui';

Color parseColor(String label) {
    const Map<String, Color> knownColors = {
      'red': Color(0xFFE53935),
      'blue': Color(0xFF1E88E5),
      'green': Color(0xFF43A047),
      'black': Color(0xFF212121),
      'white': Color(0xFFBDBDBD),
      'grey': Color(0xFF757575),
      'gray': Color(0xFF757575),
      'yellow': Color(0xFFFFB300),
      'orange': Color(0xFFFB8C00),
      'purple': Color(0xFF8E24AA),
      'pink': Color(0xFFE91E63),
      'brown': Color(0xFF6D4C41),
      'gold': Color(0xFFD4AF37),
      'silver': Color(0xFF9E9E9E),
      'navy': Color(0xFF1A237E),
      'cyan': Color(0xFF00ACC1),
    };
    return knownColors[label.toLowerCase()] ?? const Color(0xFF9E9E9E);
  }