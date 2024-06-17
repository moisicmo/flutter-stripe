import 'package:flutter/material.dart';

import 'pay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff3b5998),
            ),
            onPressed: () => payment(),
            child: const Text(
              'PAGAR CON STRIPE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  payment() async {
    StripePaymentHandle().stripeMakePayment();
  }
}
