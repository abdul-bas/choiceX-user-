import 'dart:convert';
import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/core/utils/helpers/calculate_avg_rating.dart';
import 'package:coice/data/models/prodect_model.dart';
import 'package:coice/ui/screens/product/controller/controller.dart';
import 'package:coice/core/utils/utils/snapshot_handler_without_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProductCard(
  BuildContext context,
  ProductModel productItem,
  int variantIndex,
) {
  return FutureBuilder(
    future: ProductController.readReviews(
      productId: productItem.id,
      variantIndex: variantIndex,
    ),
    builder: (context, snapshot) {
      final state = handleSnapshotWithOutIndicator(snapshot);
      if (state != null) return state;

      final List<Map<String, dynamic>> reviews = ProductController.convertReviews(snapshot.data);
      final firstVariant = productItem.variants.isNotEmpty
          ? productItem.variants[variantIndex]
          : null;

      final discount = int.parse(firstVariant?['discount'] ?? '0');

      Uint8List? imageBytes;
      if (firstVariant != null &&
          firstVariant['images'] != null &&
          (firstVariant['images'] as List).isNotEmpty) {
        try {
          imageBytes = base64Decode(firstVariant['images'][0]);
        } catch (_) {}
      }

      final double rating = calculateAverageRating(reviews);
      final int total = reviews.length;

      final String ratingDisplay =
          ProductController.formatRating(rating, total);

      return InkWell(
        onTap: () => ProductController.goToProductDetail(
          context: context,
          product: productItem,
          variantIndex: 0,
        ),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 170,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey200),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowFaint,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: imageBytes != null
                            ? Image.memory(imageBytes, fit: BoxFit.contain)
                            : Icon(Icons.image_outlined,
                                size: 60, color: AppColors.grey400),
                      ),
                    ),
                    if (discount > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.danger,
                                AppColors.dangerDark,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$discount% OFF',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    if (discount <= 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: productItem.status == 'Live'
                                ? AppColors.success
                                : AppColors.danger,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.circle,
                                  size: 6, color: AppColors.white),
                              const SizedBox(width: 3),
                              Text(
                                productItem.status == 'Live' ? 'Stock' : 'Out',
                                style: GoogleFonts.inter(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productItem.brand.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey600,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        productItem.productName,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                 ratingDisplay != '—'?   const SizedBox(height: 15):const SizedBox(height: 5),

              ratingDisplay == '—'
    ? Row(
        children: [
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.success,           
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expected Delivery',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success,         
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                ProductController.expectedDelivery(
                  productItem.expectedDeliveryDays,
                ),
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black87,
                  height: 1.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      )
    : Row(
        children: [
          const Icon(
            Icons.star,
            size: 18,
            color: AppColors.starAmber,
          ),
          const SizedBox(width: 3),
          Text(
            ratingDisplay,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
