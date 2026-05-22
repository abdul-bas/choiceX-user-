import 'package:coice/core/constants/app_strings/categories.dart';
import 'package:flutter/material.dart';

IconData getCategoryIcon(String name) {
  final key = name.toLowerCase().replaceAll(' ', '');
  return productCategories[key] ?? Icons.category;
}