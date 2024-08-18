import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        color: const Color(0xFF92E3A9),
        height: double.infinity,
        width: double.infinity,
        child: const Center(child: Text('Espanyol'),)
      ),
    );
  }
}