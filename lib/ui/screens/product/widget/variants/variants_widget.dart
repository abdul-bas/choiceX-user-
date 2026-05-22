import 'dart:typed_data';

import 'package:coice/core/utils/helpers/common/parse_color.dart';
import 'package:coice/core/utils/helpers/product_helper/variant_section/decode_image.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/widget/variants/variant_tile.dart';

import 'package:flutter/material.dart';

class VariantsWidget extends StatelessWidget {
  const VariantsWidget({
    super.key,
    required this.product,
    required this.toggleVariantIndex,
    required this.value,
  });

  final ProductModel product;
  final ValueNotifier<int> toggleVariantIndex;
  final int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.variants.length,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        itemBuilder: (context, index) {
          final variant = product.variants[index];
          final bool isSelected = index == value;
          final Uint8List? bytes = decodeImage(variant);
          final Color swatch = parseColor(variant['Color']?.toString() ?? '');

          return VariantTile(
            variant: variant,
            bytes: bytes,
            swatch: swatch,
            isSelected: isSelected,
            onTap: () => toggleVariantIndex.value = index,
          );
        },
      ),
    );
  }
}
