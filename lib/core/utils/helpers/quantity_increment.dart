import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, int>> increment(String key) async {
  final pref = await SharedPreferences.getInstance();

  final String? data = pref.getString('quantity');

  Map<String, int> quantity = {};

  if (data != null) {
    final decoded = jsonDecode(data) as Map<String, dynamic>;

    quantity = decoded.map(
      (k, v) => MapEntry(k, (v as num).toInt()),
    );
  }

  quantity[key] = (quantity[key] ?? 0) + 1;

  await pref.setString('quantity', jsonEncode(quantity));

  return quantity;
}
