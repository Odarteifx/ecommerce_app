import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolors.primaryColor,
        body: Stack(
          children: [
            Positioned(
                left: -160.w,
                top: -191.sp,
                child: Image.asset(EshopAssets.onboardingup)),
            Positioned(
                left: 213.w,
                top: 717.h,
                child: Image.asset(EshopAssets.onboardingdown)),
            SafeArea(
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      'eSh',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: EshopTypography.heading1,
                        letterSpacing: -0.3.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'op',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: EshopTypography.heading1,
                        letterSpacing: -0.3.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 1.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
