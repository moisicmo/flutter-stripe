import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment() async {
    try {
      // PASO 1
      Stripe.publishableKey = dotenv.env['PUBLISHER_KEY']!;
      Stripe.merchantIdentifier = 'any string works';
      await Stripe.instance.applySettings();
      // PASO 2
      paymentIntent = await createPaymentIntent('100', 'USD');
      // PASO 3
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          primaryButtonLabel: 'Pagar ahora',
          merchantDisplayName: 'Flutter Stripe Store Demo',
          billingDetails: const BillingDetails(
            name: 'YOUR NAME',
            email: 'YOUREMAIL@gmail.com',
            phone: 'YOUR NUMBER',
            address: Address(
              city: 'YOUR CITY',
              country: 'YOUR COUNTRY',
              line1: 'YOUR ADDRESS 1',
              line2: 'YOUR ADDRESS 2',
              postalCode: 'YOUR PINCODE',
              state: 'YOUR STATE',
            ),
          ),
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          // merchantDisplayName: 'Ikay',
        ),
      );

      // paso 4
      // displayPaymentSheet();
    } catch (e) {
      log('error $e');
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(msg: 'Payment succesfully completed');
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: $e');
      }
    }
  }

  //create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic>? body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": 'Bearer ${dotenv.env['STRIPE_SECRET']}',
      };
      final options = Options(validateStatus: (status) => status! <= 501, headers: headers);
      var response = await Dio().post('https://api.stripe.com/v1/payment_intents', data: body, options: options);

      log(json.encode(response.data));
      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
