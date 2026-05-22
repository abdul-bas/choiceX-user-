import 'package:flutter/material.dart';

void pushScreen(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => screen),
  );
}