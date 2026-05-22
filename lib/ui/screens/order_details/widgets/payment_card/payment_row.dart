import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

class PaymentRow extends StatelessWidget {
  const PaymentRow({super.key, 
    required this.label,
    required this.value,
    this.fontSize,
    this.color,
    this.fontWeight,
  });

  final String label;
  final String value;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextInter(
                text: label,
                letterSpacing: 0.5,
                fontSize: 13,
                color: color ?? AppColors.black54,  
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
            Flexible(
              child: TextInter(
                text: value,
                overFlow: TextOverflow.ellipsis,
                letterSpacing: 0.5,
                fontSize: fontSize ?? 13,
                color: color ?? AppColors.black54,   
                fontWeight: fontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
