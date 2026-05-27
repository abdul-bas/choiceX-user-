import 'package:http/http.dart' as http;


import 'dart:convert';

Future<bool> refundPayment(String paymentIntentId, double amountInRupees) async {
  const secretKey = 'Removed stripe secret';
  final url = Uri.parse('https://api.stripe.com/v1/refunds');

  try {
   
    final int amountInPaise = (amountInRupees * 100).round();

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'payment_intent': paymentIntentId,
        'amount': amountInPaise.toString(),
      },
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(' Refund successful: ${responseData}');
      return true;
    } else {
      print(' Refund failed: ${responseData}');
      return false;
    }
  } catch (e) {
    print(' Error while refunding: $e');
    return false;
  }
}