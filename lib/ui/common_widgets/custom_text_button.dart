
import 'package:coice/core/constants/app_colors.dart';
import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  AuthButton(
      {super.key,
      required this.width,
      this.color,
      required this.text,
      this.textColor,
      this.icon,
      this.hight,
      this.radius,
      this.textFont,
      this.fontSize,this.borderColor,
      this.function});

  final double width;
  Color? color;
  String text;
  Color? textColor;
  Color? borderColor;
  Icon? icon;
  final double? hight;
  Function()? function;
  final double? radius;
  final FontWeight? textFont;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: hight ?? 57,
        width: width * 0.85,
        child: TextButton(
            style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                backgroundColor: color ?? barndColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1, color:borderColor?? const Color.fromARGB(23, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(radius ?? 13),
                )),
            onPressed: () {
              if (function != null) {
                function!();
              }
            },
            child: SizedBox(
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? SizedBox(),
                  Center(
                      child: TextInter(
                    text: text,
                    letterSpacing: 0.1,
                    wordSpace: 1,
                    color: textColor,
                    fontWeight: textFont ?? FontWeight.w900,
                    fontSize: fontSize ?? 17,
                  )),
                ],
              ),
            )),
      ),
    );
  }
}
