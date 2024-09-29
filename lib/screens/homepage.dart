import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
      icon: Iconsax.user,
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

  List iconList = [
    {
      'id': 1,
      'image_path': EshopAssets.computerSystems,
      'iconName': 'Computer Systems'
    },
    {
      'id': 2,
      'image_path': EshopAssets.mobileDevices,
      'iconName': 'Mobile Devices'
    },
    {
      'id': 3,
      'image_path': EshopAssets.storageDevices,
      'iconName': 'Storage Devices'
    },
    {
      'id': 4,
      'image_path': EshopAssets.television,
      'iconName': 'TV & Home Theatre'
    },
    {'id': 5, 'image_path': EshopAssets.gamingVR, 'iconName': 'Gaming & VR'},
    {
      'id': 6,
      'image_path': EshopAssets.digitalCamera,
      'iconName': 'Digital Cameras'
    },
    {'id': 7, 'image_path': EshopAssets.headphones, 'iconName': 'Headphones'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Appcolors.backgroundColor, boxShadow: [
          BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, -1.sp),
              blurRadius: 4.sp)
        ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 22.w),
          child: GNav(
            tabBackgroundColor: Appcolors.hometabColor,
            padding: EdgeInsets.all(12.sp),
            gap: 3.sp,
            //type: BottomNavigationBarType.shifting,
            activeColor: Appcolors.bottomNavActive,
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
      body: <Widget>[
        HomePage(
            searchcontroller: _searchcontroller,
            carouselController: _carouselController,
            imageList: imageList,
            iconList: iconList),
        WishlistPage(
          searchcontroller: TextEditingController(),
        ),
        const Center(
          child: Text('Cart'),
        ),
        const ProfilePage(),
      ][currentindex],
    );
  }
}

//HomePage(searchcontroller: _searchcontroller, carouselController: _carouselController, imageList: imageList, iconList: iconList))
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required TextEditingController searchcontroller,
    required CarouselSliderController carouselController,
    required this.imageList,
    required this.iconList,
  })  : _searchcontroller = searchcontroller,
        _carouselController = carouselController;

  final TextEditingController _searchcontroller;
  final CarouselSliderController _carouselController;
  final List imageList;
  final List iconList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: EshopAppBar(searchcontroller: _searchcontroller),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  BannerSlider(
                      carouselController: _carouselController,
                      imageList: imageList),
                  SizedBox(
                    height: 15.h,
                  ),
                  CategoriesSection(iconList: iconList),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Popular Products',
                            style: GoogleFonts.roboto(
                                fontSize: EshopTypography.subtext,
                                fontWeight: EshopFontweight.semibold)),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'See more',
                            style: GoogleFonts.roboto(
                                fontSize: EshopTypography.subtext,
                                color: Appcolors.subtextColor,
                                fontWeight: EshopFontweight.regular),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  const PGridLayout()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//AppBar
class EshopAppBar extends StatelessWidget {
  const EshopAppBar({
    super.key,
    required TextEditingController searchcontroller,
  }) : _searchcontroller = searchcontroller;

  final TextEditingController _searchcontroller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: SizedBox(
                width: 260.w,
                child: Searchbar(searchcontroller: _searchcontroller))),
        Badge(
            //label: Text(''),
            alignment: Alignment(0.25.sp, -0.4.sp),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.notification))),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.messages))
      ],
    );
  }
}

//Search bar
class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
    required TextEditingController searchcontroller,
  }) : _searchcontroller = searchcontroller;

  final TextEditingController _searchcontroller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchcontroller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Iconsax.search_normal_1),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Search',
          hintStyle: GoogleFonts.roboto(
              fontSize: EshopTypography.onboadingbody,
              color: Appcolors.subtextColor)),
    );
  }
}

//Wishlist
class WishlistPage extends StatelessWidget {
  final TextEditingController searchcontroller;
  const WishlistPage({super.key, required this.searchcontroller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EshopAppBar(searchcontroller: searchcontroller),
          Text(
            'My Wishlist',
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.heading2,
                fontWeight: EshopFontweight.medium),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: Appcolors.widgetcolor,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Row(
              children: [
                Image.asset(EshopAssets.product1),
                Container(
                  width: 180.h,
                  height: 160.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Beats Studio Pro – Premium Wireless Noise Cancelling Headphones',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '\$59.99',
                        style: GoogleFonts.roboto(
                            fontWeight: EshopFontweight.medium,
                            fontSize: EshopTypography.homepagecategories,
                            decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        '\$39.50',
                        style: GoogleFonts.roboto(
                            fontSize: EshopTypography.subtext,
                            fontWeight: EshopFontweight.medium,
                            color: Appcolors.promptColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){},
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Appcolors.iconColor),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.add,
                                    size: 22.sp,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: GoogleFonts.roboto(
                                        fontSize: EshopTypography.subtext,
                                        fontWeight: EshopFontweight.regular),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Appcolors.iconColor),
                                  borderRadius: BorderRadius.circular(50.r)),
                              child: Center(
                                  child: IconButton(
                                onPressed: () {},
                                icon: Icon(Iconsax.heart5),
                                color: Appcolors.promptColor,
                              )))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

//Profile page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'My Account',
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.heading2,
                fontWeight: EshopFontweight.medium),
          ),
          SizedBox(height: 30.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: const AssetImage(EshopAssets.person),
                radius: 25.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'William Lamptey',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.onboadingbody,
                        fontWeight: EshopFontweight.medium),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text('williamlamptey12@yahoo.com',
                      style: GoogleFonts.roboto(
                          fontSize: EshopTypography.subtext,
                          color: Appcolors.subtextColor,
                          fontWeight: EshopFontweight.light))
                ],
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Iconsax.edit,
                    color: Appcolors.subtextColor,
                  ))
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileWidget(
                    icon: Iconsax.box,
                    iconText: 'My Orders',
                    onpressed: () {},
                  ),
                  ProfileWidget(
                    icon: Iconsax.crown_1,
                    iconText: 'Insider',
                    onpressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileWidget(
                    icon: Iconsax.discount_shape,
                    iconText: 'Coupons',
                    onpressed: () {},
                  ),
                  ProfileWidget(
                    icon: Icons.headset_mic_outlined,
                    iconText: 'Help Center',
                    onpressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              ProfileTile(
                icon: Iconsax.heart,
                iconText: 'Wishlist',
                onpressed: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
              ProfileTile(
                icon: Iconsax.location,
                iconText: 'Delivery address',
                onpressed: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
              ProfileTile(
                icon: Iconsax.wallet_3,
                iconText: 'Saved cards & Wallets',
                onpressed: () {},
              ),
              SizedBox(
                height: 20.h,
              ),
              ProfileTile(
                icon: Iconsax.setting_3,
                iconText: 'Security settings',
                onpressed: () {},
              ),
            ],
          )
        ],
      ),
    ));
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.iconText,
    this.onpressed,
  });

  final IconData icon;
  final String iconText;
  final VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: Appcolors.subtextColor,
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            iconText,
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.onboadingbody,
                fontWeight: EshopFontweight.regular),
          ),
          const Expanded(child: SizedBox()),
          const Icon(
            Iconsax.arrow_right_3,
            size: 20,
            color: Appcolors.iconColor,
          )
        ],
      ),
    );
  }
}
