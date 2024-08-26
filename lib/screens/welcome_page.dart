import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/screens/eshop_pageview.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingAsset(imagePath: EshopAssets.welcome),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Wrap(
              children: [
                Text(
                  'Welcome to ',
                  style: GoogleFonts.roboto(
                      fontSize: EshopTypography.heading2,
                      fontWeight: EshopFontweight.medium),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'eShop',
                  style: GoogleFonts.roboto(
                      fontSize: EshopTypography.heading2,
                      fontWeight: EshopFontweight.medium,
                      color: Appcolors.primaryColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Text(
              'Your gateway to discovering and shopping the world’s most exciting products. Whether you\'re here for the latest trends, exclusive deals, or simply to find something new, we\'ve got you covered.',
              style: GoogleFonts.roboto(
                fontSize: EshopTypography.onboadingbody,
                fontWeight: EshopFontweight.light,
              ),
            ),
          ),
          SizedBox(
            height: 124.h,
          ),
          MajorButton(
              buttonText: 'Get Started',
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EshopPageview(),
                    ));
              })
        ],
      ),
    );
  }
}
