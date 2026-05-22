import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class MagazineCard extends StatelessWidget {
  const MagazineCard({
    super.key,
    required this.bytes,
    required this.brand,
    required this.name,
    required this.fmtDisc,
    required this.fmtOrig,
    required this.discount,
    required this.hasDiscount,
    required this.onRemove,
    required this.onView,
  });

  final Uint8List    bytes;
  final String       brand;
  final String       name;
  final String       fmtDisc;
  final String       fmtOrig;
  final String       discount;
  final bool         hasDiscount;
  final VoidCallback onRemove;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onView,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
          
            Image.memory(bytes, fit: BoxFit.cover),

           
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.35, 1.0],
                    colors: [
                      AppColors.transparent,   
                      AppColors.onImageDark,     
                    ],
                  ),
                ),
              ),
            ),

          
            Positioned(
              top: 10, left: 10, right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (hasDiscount)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.danger,  
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '-$discount%',
                        style: const TextStyle(
                          color: AppColors.white, 
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  else
                    const SizedBox(),

               
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Material(
                      color: AppColors.onImageWhiteStrong,
                      shape: const CircleBorder(),
                      child: IconButton(                  
                        padding: EdgeInsets.zero,
                        iconSize: 15,
                        onPressed: onRemove,
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.iconDark,       
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          
            Positioned(
              left: 0, right: 0, bottom: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  
                    Text(
                      brand.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onImageWhiteMid,
                        letterSpacing: 1.6,
                      ),
                    ),
                    const SizedBox(height: 2),

                   
                    const Text(
                      '',                             
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,         
                        height: 1.25,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹$fmtDisc',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: AppColors.white, 
                                letterSpacing: -0.4,
                              ),
                            ),
                            if (hasDiscount)
                              Text(
                                '₹$fmtOrig',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  color: AppColors.onImageWhiteFaint,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.onImageWhiteFaint,
                                ),
                              ),
                          ],
                        ),

                      
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.brand,      
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.white,    
                            size: 16,
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
  }
}
