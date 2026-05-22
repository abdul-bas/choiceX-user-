import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class UnavailableItem extends StatelessWidget {        
  const UnavailableItem({super.key, required this.onRemove});

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,            
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: AppColors.borderError, width: 1.2), 
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark,         
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: AppColors.surfaceError,  
                        child: const Icon(
                          Icons.hide_image_outlined,
                          color: AppColors.dangerSubtle,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0, left: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      color: AppColors.danger.withValues(alpha: 0.88), 
                      child: const Text(
                        'Unavailable',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,     
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              height: 11,
                              decoration: BoxDecoration(
                                color: AppColors.skeletonBase, 
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 11,
                              decoration: BoxDecoration(
                                color: AppColors.skeletonBase,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Container(
                          height: 9,
                          decoration: BoxDecoration(
                            color: AppColors.skeletonLight, 
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

     
        Positioned(
          top: 6, right: 6,
          child: SizedBox(
            width: 30,
            height: 30,
            child: Material(
              color: AppColors.danger.withValues(alpha:  0.90),
              shape: const CircleBorder(),
              child: IconButton(                       
                padding: EdgeInsets.zero,
                iconSize: 15,
                onPressed: onRemove,
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.white,         
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
