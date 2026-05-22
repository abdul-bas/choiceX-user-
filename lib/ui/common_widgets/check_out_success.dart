import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/ui/common_widgets/checkout_circle_widget.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/text_cripson.dart';
import 'package:flutter/material.dart';
Widget checkOutSuccessPop({
  String? title,
  String? subText,
  String? buttonText,
  String? image,
  Color? iconBackgroundColor,
  required VoidCallback onPressed,
}) {
  final accent = iconBackgroundColor ?? const Color(0xFF22C55E);

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha:  0.08),
          blurRadius: 30,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),

          
          if (image != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(image, height: 140, fit: BoxFit.contain),
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
                    color: accent.withValues(alpha:  0.08),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha:  0.15),
                  ),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent,
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha:  0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

    
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: TextInter(
                textAlign: TextAlign.center,
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

          if (title != null) const SizedBox(height: 6),

        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextCrimson(
              textAlign: TextAlign.center,
              text: subText ?? 'Order placed successfully!',
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 20),

          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(child: Divider(color: Colors.grey.shade100)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'ORDER STATUS',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.6,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: Colors.grey.shade100)),
              ],
            ),
          ),

          const SizedBox(height: 16),

         
          const CheckoutCircleWidget(
            addressCompleeted: true,
            peymentCompleeted: true,
            summeryCompleeted: true,
          ),

          const SizedBox(height: 20),

         
          if (buttonText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: onPressed,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: barndColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:  0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}