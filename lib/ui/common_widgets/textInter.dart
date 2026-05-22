import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextInter extends StatelessWidget {
  TextInter(
      {super.key,
      this.fontSize,
      this.fontWeight,
      this.letterSpacing,
      this.color,
      required this.text,
      this.maxLines,
      this.overFlow,
      this.textAlign,
      this.decoration,this.undelineColor,
      this.wordSpace});
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final String text;
  double? wordSpace;
  final TextOverflow? overFlow;
  final int? maxLines;
  TextAlign? textAlign;
  final TextDecoration? decoration;
  final Color? undelineColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.inter(
          decoration: decoration,
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? FontWeight.bold,
          letterSpacing: letterSpacing ?? -1,
          color: color ?? Colors.black,
          decorationColor:undelineColor?? Colors.white,
          wordSpacing: wordSpace ?? 0),
    );
  }
}
