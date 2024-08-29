import 'package:ecommerce_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class EshopHomePage extends StatelessWidget {
  const EshopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(child: SizedBox( 
                    width: 260.w,
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search'
                      ),
                    ))),
                  Badge(
                    //label: Text(''),
                    alignment:  Alignment(0.25.sp, -0.4.sp),
                    child: IconButton(onPressed: (){}, icon: const Icon(Iconsax.notification))
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Iconsax.messages))
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}