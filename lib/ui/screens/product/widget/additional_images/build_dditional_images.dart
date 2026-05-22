import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

Widget buildAdditionalImages(dynamic imges) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        const SizedBox(height:10.0),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imges.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final Uint8List bytes = base64Decode(imges[index]);
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(bytes, fit: BoxFit.cover),
            );
          },
        ),
      ],
    );
  }