import 'package:flutter/material.dart';

class EshopHomePage extends StatefulWidget {
  const EshopHomePage({super.key});

  @override
  State<EshopHomePage> createState() => _EshopHomePageState();
}

class _EshopHomePageState extends State<EshopHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Welcome'),
    );
  }
}