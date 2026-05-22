
import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_slab.dart';
import 'package:flutter/material.dart';

class AnimatedCircleProgressDesign extends StatelessWidget {
  const AnimatedCircleProgressDesign({
    super.key,
    this.isCompleet = false,
    required this.label,
    required this.number,
    required this.isSelect,
  });

  final String label;
  final String number;
  final bool isSelect;
  final bool isCompleet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: isCompleet ? barndColor.withOpacity(0.6) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: isSelect ? barndColor : brandLessShade,
            ),
          ),
          child: isCompleet
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 17,
                )
              : TextInter(
                  text: number,
                  color: isSelect ? barndColor : brandLessShade,
                ),
        ),
        const SizedBox(height: 5),
        TextSlab(
          fontSize: 11,
          text: label,
          color: isSelect ? Colors.black : Colors.grey,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        )
      ],
    );
  }
}