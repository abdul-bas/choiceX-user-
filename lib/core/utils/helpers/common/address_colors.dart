import 'dart:ui';

Color getAddressColor(String nickName) {
    switch (nickName.toLowerCase()) {
      case 'home':
        return const Color(0xFF06C270);
      case 'work':
      case 'office':
        return const Color(0xFFFF8C00);
      case 'partner':
      case 'family':
        return const Color(0xFFFF4B91);
      default:
        return const Color(0xFF4F6FFF);
    }
  }