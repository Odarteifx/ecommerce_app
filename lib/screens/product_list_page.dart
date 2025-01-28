import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text('Product List'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.sort))
        ],
      ),
      body: SingleChildScrollView(child: ProductWidget()),
    );
  }
}