import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/screens/welcome_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ));
    });
    super.initState();
  }

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
            const SafeArea(
              child: Center(
                  child: EshopLogo(
                logoColor: Appcolors.backgroundColor,
              )),
            )
          ],
        ));
  }
}
