import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';

class EshopHomePage extends StatelessWidget {
  const EshopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: Center(child: Text('Welcome')),
    );
  }
}