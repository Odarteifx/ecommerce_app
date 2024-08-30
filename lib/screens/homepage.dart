import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EshopHomePage extends StatefulWidget {
  const EshopHomePage({super.key});

  @override
  State<EshopHomePage> createState() => _EshopHomePageState();
}

class _EshopHomePageState extends State<EshopHomePage> {
late final TextEditingController _searchcontroller;

@override
  void initState() {
    super.initState();
    _searchcontroller = SearchController();
  }

  @override
  void dispose() {
   _searchcontroller.dispose();
    super.dispose();
  }

  List imageList= [
    {'id': 1, 'image_path': EshopAssets.banner1} ,
    {'id': 2, 'image_path': EshopAssets.banner2},
  ];

  final CarouselController _carouselController = CarouselController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SingleChildScrollView(
                child: Column(
                  children: [
                  
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
