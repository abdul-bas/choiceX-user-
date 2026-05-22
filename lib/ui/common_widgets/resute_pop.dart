import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';

class ResutePop extends StatelessWidget {
  const ResutePop({
    super.key,
    required this.headText,
    required this.subText,
    required this.buttonText,
    required this.normalColor,
    required this.transparentColor,
    required this.icon,
    this.onTap,
    this.image,
  });

  final String headText;
  final String subText;
  final Color normalColor;
  final Color transparentColor;
  final String buttonText;
  final String? image;
  final IconData icon;

  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 28),
          if (image != null)
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
         Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: normalColor.withValues(alpha:  0.08),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: normalColor.withValues(alpha:  0.15),
          ),
        ),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: normalColor,
            boxShadow: [
              BoxShadow(
                color: normalColor.withValues(alpha:  0.35),
                blurRadius: 16,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: 28, color: AppColors.white),  
        ),
      ],
    ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: TextSlab(
              textAlign: TextAlign.center,
              text: headText,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextInter(
              maxLines: 3,
              overFlow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              text: subText,
              color: AppColors.textHint,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onTap != null ? () => onTap!(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: normalColor,
                  foregroundColor: AppColors.white,
                  elevation: 6,
                  shadowColor: normalColor.withValues(alpha:  0.30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
