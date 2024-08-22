import 'package:ecommerce_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF92E3A9),
        body: Stack(
          children: [
            Positioned(
                left: -160.w,
                top: -191.sp,
                child: Image.asset('assets/Vectoronboardingup.png')),
            Positioned(
                left: 213.w,
                top: 717.h,
                child: Image.asset('assets/Vectoronbordingdown.png')),
            SafeArea(
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      'eSh',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 32.sp,
                        letterSpacing: -0.3.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'op',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 32.sp,
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
