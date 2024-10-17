import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Appcolors.widgetcolor,
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Iconsax.shopping_cart))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            Stack(
              children: [
                Container(
                  height: 500.h,
                  decoration: BoxDecoration(
                    color: Appcolors.widgetcolor
                  ),
                  child: Center(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                 left: 5.sp,
                  
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_sharp))),
                  Positioned(
                    right: 5.sp,
                    child: Row(
                      children: [
                    IconButton(onPressed: (){}, icon: Icon(Iconsax.heart)),
                    IconButton(onPressed: (){}, icon: Icon(Iconsax.bag_2)),
                  ],))
              ],
            )
          ],
        ),
      ),
    );
  }
}
