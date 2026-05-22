import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, int>> decrement(String key) async {
  final pref = await SharedPreferences.getInstance();

  String? data = pref.getString('quantity');
  Map<String, int> quantity = {};
  final decoded = data == null ? {} : jsonDecode(data) as Map<String, dynamic>;
  quantity = decoded.map((k, v) => MapEntry(k, (v as num).toInt()));

  if (!quantity.containsKey(key)) {
    return quantity;
  }

  int newValue = quantity[key] ?? 1;

if (newValue > 1) {
  newValue = newValue - 1;
} else {
  newValue = 1;
}

  if (newValue <= 0) {
    quantity.remove(key);
    await pref.setString('quantity', jsonEncode(quantity));
    return quantity;
  }

  quantity[key] = newValue;
  await pref.setString('quantity', jsonEncode(quantity));

  return quantity;
}
