import 'dart:convert';
import 'dart:typed_data';

Uint8List? decodeImage(Map<dynamic, dynamic> variant) {
    if (variant['images'] == null) return null;
    try {
      return base64Decode(variant['images'][0]);
    } catch (_) {
      return null;
    }
  }