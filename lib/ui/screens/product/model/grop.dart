
import 'package:coice/ui/screens/product/model/spec_item.dart';
import 'package:flutter/material.dart';

class Group {
  final String title;
  final IconData icon;
  final List<SpecItem> items;

  const Group({
    required this.title,
    required this.icon,
    required this.items,
  });
}