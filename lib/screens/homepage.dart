import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class EshopHomePage extends StatefulWidget {
  const EshopHomePage({super.key});

  @override
  State<EshopHomePage> createState() => _EshopHomePageState();
}

class _EshopHomePageState extends State<EshopHomePage> {
  late final TextEditingController _searchcontroller;

  List<GButton> bottomNavBarList = const <GButton>[
    GButton(
      icon: Iconsax.home,
      text: 'Home',
      //activeIcon: Icon(Iconsax.home_15)
    ),
    GButton(
      icon: Iconsax.heart,
      text: 'Wishlist',
      // activeIcon: Icon(Iconsax.heart5)
    ),
    GButton(
      icon: Iconsax.shopping_cart,
      text: 'Cart',
      // activeIcon: Icon(Iconsax.shopping_cart5)
    ),
    GButton(
      icon: Iconsax.profile_circle,
      text: 'Profile',
      // activeIcon: Icon(Iconsax.profile_circle5)
    )
  ];

  @override
  void initState() {
    super.initState();
    _searchcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int currentindex = 0;
  int bannerindex = 0;

  List imageList = [
    {'id': 1, 'image_path': EshopAssets.banner1},
    {'id': 2, 'image_path': EshopAssets.banner2},
    {'id': 3, 'image_path': EshopAssets.banner2},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Appcolors.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 22.w),
            child: GNav(
              tabBackgroundColor: Appcolors.hometabColor,
              padding: EdgeInsets.all(12.sp),
              gap: 3,
              //type: BottomNavigationBarType.shifting,
              activeColor: Appcolors.textColor,
              color: Appcolors.subtextColor,
              selectedIndex: currentindex,
              tabs: bottomNavBarList,
              onTabChange: (value) {
                setState(() {
                  currentindex = value;
                });
              },
            ),
          ),
        ),
        backgroundColor: Appcolors.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Flexible(
                        child: SizedBox(
                            width: 260.w,
                            child: TextField(
                              controller: _searchcontroller,
                              decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Iconsax.search_normal_1),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: 'Search',
                                  hintStyle: GoogleFonts.roboto(
                                      fontSize: EshopTypography.onboadingbody,
                                      color: Appcolors.subtextColor)),
                            ))),
                    Badge(
                        //label: Text(''),
                        alignment: Alignment(0.25.sp, -0.4.sp),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.notification))),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Iconsax.messages))
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Stack(
                      children: [
                        SizedBox(
                          height: 175.h,
                          width: 350.w,
                          child: CarouselSlider(
                              carouselController: _carouselController,
                              items: imageList.map((image) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.h),
                                  child: BannerWidget(
                                    imageUrl: image['image_path'],
                                    onpressed: () {},
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  bannerIndexNotifier.value = index;
                                },
                              )),
                        ),
                        Positioned(
                            left: 160.w,
                            top: 165.h,
                            child: Row(
                              children: [
                                ValueListenableBuilder<int>(
                                  valueListenable: bannerIndexNotifier,
                                  builder: (BuildContext context, bannerindex,
                                      Widget? child) {
                                    return SmoothPageIndicator(
                                      controller: PageController(
                                          initialPage: bannerindex),
                                      onDotClicked: (index) {
                                        _carouselController
                                            .animateToPage(index);
                                      },
                                      count: 3,
                                      effect: ExpandingDotsEffect(
                                          dotColor: Appcolors.iconColor,
                                          activeDotColor:
                                              Appcolors.primaryColor,
                                          dotWidth: 6.w,
                                          dotHeight: 2.h,
                                          spacing: 6.w),
                                    );
                                  },
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
