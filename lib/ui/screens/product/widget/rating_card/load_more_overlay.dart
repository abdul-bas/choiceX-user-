
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/state/bloc/product/poroduct_event/load_rating.dart';
import 'package:coice/state/bloc/product/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
Widget buildLoadMoreOverlay(
  ProductBloc bloc,
  String productId,
  int variantIndex,
  BuildContext context,
) =>
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 110,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.reviewFadeStart,                 
              AppColors.reviewFadeEnd,                   
            ],
          ),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(                                 
          onTap: () => context.read<ProductBloc>().add(
                LoadRating(
                  productId: productId,
                  variantIndex: variantIndex,
                  limit: 3,
                ),
              ),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,            
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: AppColors.reviewBorderLight,    
                  width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,       
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See more reviews',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey700,          
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: AppColors.brand,           
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.white,            
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );