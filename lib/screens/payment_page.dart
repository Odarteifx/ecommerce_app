import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Form(child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Card Number',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Expiry Date',
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'CVV',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add payment logic here
            },
            child: Text('Pay'),
          ),
        ],
      )),
    );
  }
}