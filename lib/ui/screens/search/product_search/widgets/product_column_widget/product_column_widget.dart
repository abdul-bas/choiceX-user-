
import 'dart:typed_data';

import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/screens/product/product_detail_page.dart';
import 'package:flutter/material.dart';

class ProductColumnWidget extends StatelessWidget {
  const ProductColumnWidget({
    super.key,
    required this.data,
    required this.bytes,
  });

  final ProductModel data;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ProductDetailPage(product: data, variantIndex: 0),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              color: AppColors.white,
              image: DecorationImage(
                image: MemoryImage(bytes),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInter(
                      letterSpacing: 0.3,
                      text: data.productName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      color: AppColors.black87,
                    ),
                    TextInter(
                      letterSpacing: 0.3,
                      text: '${data.productType} | ${data.model}',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.grey600,
                    ),
                  ],
                ),
                TextInter(
                  text: data.brand,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                TextInter(
                  text: data.category,
                  fontSize: 13,
                  color: AppColors.grey500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}