import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton(
      {super.key,
      this.textType,
      this.obs,
      this.frontIcon,
      required this.isFocused,
      this.sufixIcon,
      required this.text,
      this.onChange,
      this.validator,
      this.function,
      this.obscure,
      this.trailingIcon,
      this.radius,
      this.items,
      this.obs2});

  final TextInputType? textType;
  final bool? obs;
  final bool? obs2;
  final Icon? frontIcon;
  final bool isFocused;
  final bool? sufixIcon;
  final Widget? trailingIcon;
  final Function? function;
  final double? radius;
  String? Function(String?)? validator;
  final List<String>? items;
  final String text;
  final bool? obscure;
  void Function(String?)? onChange;
  

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      onChanged: onChange,
      items: items
          ?.map((item) => DropdownMenuItem(
              alignment: Alignment.centerLeft, value: item, child: Text(item)))
          .toList(),
      style: GoogleFonts.robotoSlab(color: Colors.black),
      decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(radius ?? 15)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: const Color.fromARGB(104, 244, 67, 54)),
              borderRadius: BorderRadius.circular(radius ?? 15)),
          prefixIcon: frontIcon,
          prefixIconColor:
              isFocused ? Colors.black : const Color.fromARGB(95, 0, 0, 0),
          suffixIcon: trailingIcon ??
              (sufixIcon != null
                  ? IconButton(
                      onPressed: () {
                        if (function != null) {
                          function!();
                        }
                      },
                      icon: Icon(
                        obscure == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isFocused
                            ? Colors.black
                            : const Color.fromARGB(95, 0, 0, 0),
                      ),
                    )
                  : null),
          enabled: true,
          filled: true,
          fillColor: Color.fromARGB(15, 0, 0, 0),
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(62, 0, 0, 0)),
              borderRadius: BorderRadius.circular(radius ?? 15)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
