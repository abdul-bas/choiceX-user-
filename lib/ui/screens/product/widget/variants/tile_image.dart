import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class TileImage extends StatelessWidget {
  const TileImage({super.key, this.bytes, required this.swatch});

  final Uint8List? bytes;
  final Color swatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
      
        color: swatch.withValues(alpha: 0.03),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 52),
        child: bytes != null
            ? Image.memory(bytes!, fit: BoxFit.contain)
            : Image.asset(
                'assets/images/no_image.png',
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
