import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/screens/pageview_one.dart';
import 'package:ecommerce_app/screens/pageview_three.dart';
import 'package:ecommerce_app/screens/pageview_two.dart';
import 'package:ecommerce_app/screens/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class EshopPageview extends StatefulWidget {
  const EshopPageview({super.key});

  @override
  State<EshopPageview> createState() => _EshopPageviewState();
}

class _EshopPageviewState extends State<EshopPageview> {
  final PageController _controller = PageController();

  bool onlastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onlastpage = (value == 2);
              });
            },
            children: const [
              PageviewOne(),
              PageviewTwo(),
              PageviewThree(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Container(
                alignment: const Alignment(0, 0.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    onlastpage
                        ? const TextButton(onPressed: null, child: Text(''))
                        : TextButton(
                            onPressed: () {
                              _controller.jumpToPage(2);
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.roboto(
                                  color: Appcolors.subtextColor,
                                  fontSize: EshopTypography.subtext,
                                  fontWeight: EshopFontweight.medium),
                            )),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          dotColor: Appcolors.iconColor,
                          activeDotColor: Appcolors.primaryColor,
                          dotWidth: 8.w,
                          dotHeight: 8.h,
                          spacing: 6.w),
                    ),
                    onlastpage
                        ? FilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EshopSignInPage(),
                                  ));
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Appcolors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text(
                              'Done',
                              style: GoogleFonts.roboto(
                                  fontWeight: EshopFontweight.medium,
                                  fontSize: EshopTypography.subtext),
                            ))
                        : FilledButton(
                            onPressed: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeIn);
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: Appcolors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text(
                              'Next',
                              style: GoogleFonts.roboto(
                                  fontWeight: EshopFontweight.medium,
                                  fontSize: EshopTypography.subtext),
                            ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

//Order Status with background
class OrderStatus extends StatelessWidget {
  final Color backgroundColor;
  final Color statusColor;
  final String status;
  const OrderStatus({
    super.key,
    required this.backgroundColor,
    required this.statusColor,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
            color: statusColor,
            fontSize: EshopTypography.termsfont,
            fontWeight: EshopFontweight.semibold),
      ),
    );
  }
}
