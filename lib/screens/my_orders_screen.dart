import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text('My Orders'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Order ID: 123456'),
              subtitle: Text('Order Date: 12/12/2022'),
              trailing: Text('GHS 200.00'),
            ),
            ListTile(
              title: Text('Order ID: 123456'),
              subtitle: Text('Order Date: 12/12/2022'),
              trailing: Text('GHS 200.00'),
            ),
            ListTile(
              title: Text('Order ID: 123456'),
              subtitle: Text('Order Date: 12/12/2022'),
              trailing: Text('GHS 200.00'),
            ),
            ListTile(
              title: Text('Order ID: 123456'),
              subtitle: Text('Order Date: 12/12/2022'),
              trailing: Text('GHS 200.00'),
            ),
            ListTile(
              title: Text('Order ID: 123456'),
              subtitle: Text('Order Date: 12/12/2022'),
              trailing: Text('GHS 200.00'),
            ),
          ],
      ),
    ));
  }
}