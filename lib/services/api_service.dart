import 'dart:convert';
import 'dart:developer';

import 'package:fire_auth/models/product_list_response.dart';
import 'package:fire_auth/utils/api_constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ProductListResponse?> getProductList() async {
    try {
      Uri url = Uri.parse(ApiConstants.baseUrl + ApiConstants.productList);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        ProductListResponse productListResponse = ProductListResponse.fromJson(jsonDecode(response.body));
        return productListResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

 Future createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // return PaymentIntent.fromJson(json.decode(response.body));
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
