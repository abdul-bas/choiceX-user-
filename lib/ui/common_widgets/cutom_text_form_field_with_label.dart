import 'package:coice/ui/common_widgets/textInter.dart';
import 'package:coice/ui/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextFeild extends StatelessWidget {
  AuthTextFeild(
      {super.key,
      required this.text,
      this.frontIcon,
      this.sufixIcon,
      this.textType,
      this.hintText,
      this.validator,
      this.obscure,
      this.obs,
      this.controller,
      this.function,
      this.maxLines,
      this.radius,
      this.obs2});
  String text;
  bool? sufixIcon;
  Widget? frontIcon;
  TextInputType? textType;
  String? hintText;
  bool? obs;
  final int? maxLines;
  bool? obs2;
  final bool? obscure;
  String? Function(String?)? validator;
  TextEditingController? controller;
  final Function? function;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(builder: (context) {
        final isFocused = Focus.of(context).hasFocus;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          TextInter(
            text: hintText ?? 'Password',
            letterSpacing: 0.3,
            fontSize: isFocused ? 16 : 14,
            color: isFocused ? Colors.black : const Color.fromARGB(95, 0, 0, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: AuthTextFormField(
                maxLines: maxLines ?? 1,
                textType: textType,
                obs: obs,
                obs2: obs2,
                obscure: obscure,
                validator: validator,
                frontIcon: frontIcon,
                controller: controller,
                function: function,
                isFocused: isFocused,
                sufixIcon: sufixIcon,
                radius: radius,
                text: text),
          ),
        ]);
      }),
    );
  }
}
