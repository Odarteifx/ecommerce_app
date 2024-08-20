import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: const Color(0xFF92E3A9),
          height: double.infinity,
          width: double.infinity,
          child: const Center(
            child: Wrap(
              children: [
                Text(
                  'eSh',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                      letterSpacing: -0.25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                ),
                Text(
                  'op',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 32,
                      letterSpacing: -0.25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 1.5,
                    ),
                ),
              ],
            ),
          )),
    );
  }
}
