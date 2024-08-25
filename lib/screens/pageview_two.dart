import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/eshop_typography.dart';

class PageviewTwo extends StatelessWidget {
  const PageviewTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 57.h,
          ),
          const OnboardingAsset(imagePath: EshopAssets.pageview2),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Text(
              'Secure Checkout',
              style: GoogleFonts.roboto(
                  fontSize: EshopTypography.heading2,
                  fontWeight: EshopFontweight.medium),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Text(
              'Shop with confidence, knowing your information is protected.',
              style: GoogleFonts.roboto(
                  fontSize: EshopTypography.onboadingbody,
                  fontWeight: EshopFontweight.light),
            ),
          )
        ],
      ),
    );
  }
}
