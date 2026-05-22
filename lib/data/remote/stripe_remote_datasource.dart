import 'dart:convert';
import 'package:coice/core/constants/api_keys/stripe.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createPaymentIntent(
    String amount, String currency) async {
  final response = await http.post(
    Uri.parse('https://api.stripe.com/v1/payment_intents'),
    headers: {
      'Authorization': 'Bearer $secretApiKey',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'amount': (int.parse(amount) * 100).toString(),
      'currency': currency,
    },
  );

  return jsonDecode(response.body);
}