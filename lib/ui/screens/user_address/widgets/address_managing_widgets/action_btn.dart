import 'package:flutter/material.dart';

class AddressActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;       
  final VoidCallback onTap;

  const AddressActionBtn({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}