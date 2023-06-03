import 'dart:convert';

import 'package:fire_auth/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../models/product.dart';

class CheckoutProvider extends ChangeNotifier {
  late ApiService _apiService;

  CheckoutProvider() {
    _apiService = ApiService();
  }

  List<Product> _addedItemList = [];

  var paymentIntent;

  ///Getters
  List<Product> get addedItemList => _addedItemList;

  void addItemToCart(Product item) {
    _addedItemList.add(item);
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _addedItemList.removeAt(index);
    notifyListeners();
  }

  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await _apiService.createPaymentIntent('100', 'USD');

print(paymentIntent);
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(

                  customFlow: true,
                  merchantDisplayName: 'Drivehome',
                paymentIntentClientSecret: paymentIntent['client_secret'],
                  // paymentIntentClientSecret: paymentIntent?['STRIPE_SECRET'], //Gotten from payment intent
                  style: ThemeMode.system,
                customerId: paymentIntent['customer'],
                  ))
          .then((value) {

      });

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }
}
