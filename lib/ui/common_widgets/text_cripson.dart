import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextCrimson extends StatelessWidget {
  TextCrimson(
      {super.key,
      this.fontSize,
      this.fontWeight,
      this.letterSpacing,
      this.color,
      required this.text,
      this.maxLine,
      this.textOverflow,
      this.textAlign,
      this.wordSpace});
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final Color? color;
  final String text;
  double? wordSpace;
  int? maxLine;
  TextOverflow? textOverflow;
  TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLine,
        overflow: textOverflow,
        textAlign: textAlign,
        style: GoogleFonts.crimsonText(
            fontSize: fontSize ?? 14,
            fontWeight: fontWeight ?? FontWeight.bold,
            letterSpacing: letterSpacing ?? -1,
            color: color ?? Colors.black,
            wordSpacing: wordSpace ?? 0));
  }
}
