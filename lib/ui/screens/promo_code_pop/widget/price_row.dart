import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';


class CartPriceRow extends StatelessWidget {
  const CartPriceRow({
    super.key,
    required this.formattedSubtotal,
    this.title,
    this.multiplicationOption,
    this.colorShade,
    this.fontWeight,
    this.fontSize,
  });

  final String formattedSubtotal;
  final String? title;
  final String? multiplicationOption;
  final Color? colorShade;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextInter(
            text: title ?? 'Subtotal',
            letterSpacing: 0.3,
            fontSize: fontSize ?? 15,
            color: colorShade ?? AppColors.textMuted, 
            fontWeight: FontWeight.w500,
          ),
          TextInter(
            text: '${multiplicationOption ?? ''} $formattedSubtotal',
            letterSpacing: 0.3,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
        ],
      ),
    );
  }
}