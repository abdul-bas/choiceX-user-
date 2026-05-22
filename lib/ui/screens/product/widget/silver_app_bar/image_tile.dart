import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({super.key, required this.raw});

  final dynamic raw;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes;
    try {
      bytes = base64Decode(raw as String);
    } catch (_) {
      bytes = Uint8List(0);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: DecorationImage(
            image: bytes.isEmpty
                ? const AssetImage('assets/images/mobile image.webp')
                : MemoryImage(bytes) as ImageProvider,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
