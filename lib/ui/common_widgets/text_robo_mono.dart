import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextRobotoMono extends StatelessWidget {
  const TextRobotoMono(
      {super.key,
      this.fontSize,
      this.overFlow,
      this.maxLines,
      this.fontWeight,
      this.letterSpacing,
      this.color,
      required this.text});
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final String text;
  final TextOverflow? overFlow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: GoogleFonts.robotoMono(
        fontSize: fontSize ?? 17,
        fontWeight: fontWeight ?? FontWeight.bold,
        letterSpacing: letterSpacing ?? -1,
        color: color ?? Colors.black,
      ),
    );
  }
}

