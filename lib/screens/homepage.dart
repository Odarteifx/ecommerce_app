import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_assets.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/wishlist_controller.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:ecommerce_app/screens/shipping_screen.dart';
import 'package:ecommerce_app/screens/signin_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'added_address_screen.dart';
import 'my_orders_screen.dart';
import 'product_list_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Appcolors.backgroundColor, boxShadow: [
          BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, -0.5.sp),
              blurRadius: 1.sp)
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
        ),
        WishlistPage(
          searchcontroller: TextEditingController(),
        ),
        MyCartPage(),
        const ProfilePage(),
      ][currentindex],
    );
  }
}

class MyCartPage extends ConsumerWidget {
  const MyCartPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    double getTotalPrice(List<CartItem> items) {
      return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    }

    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'My Cart (${cartItems.asData!.value.length})',
                        style: GoogleFonts.roboto(
                            fontSize: 20.sp, color: Appcolors.textColor),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          ref.read(cartControllerProvider.notifier).clearCart();
                        },
                        icon: const Icon(
                          Iconsax.trash,
                          color: Appcolors.textColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Container(
                      child: cartItems.when(
                        data: (items) {
                          if (items.isEmpty) {
                            return Center(
                                child: Text(
                              'No items in the cart',
                              style: GoogleFonts.roboto(
                                  color: Appcolors.iconColor,
                                  fontSize: EshopTypography.onboadingbody),
                            ));
                          }
                          return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final CartItem item = items[index];
                              return Slidable(
                                key: Key(item.productId),
                                endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),
                                    children: [
                                      SlidableAction(
                                        icon: Iconsax.trash,
                                        backgroundColor: Appcolors.promptColor,
                                        foregroundColor: Colors.white,
                                        label: 'Delete',
                                        onPressed: (context) {
                                          ref
                                              .read(cartControllerProvider
                                                  .notifier)
                                              .removeFromCart(item.productId);
                                        },
                                      )
                                    ]),
                                child: ListTile(
                                  onTap: () {
                                    debugPrint(
                                        '${item.image}, ${item.productName}, ${item.productId}');
                                  },
                                  leading: Container(
                                    height: 50.h,
                                    width: 50.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      image: DecorationImage(
                                        image: item.image != null
                                            ? NetworkImage(item.image!)
                                            : const AssetImage(
                                                    EshopAssets.product1)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    item.productName,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      IconButton(
                                        iconSize: 15.sp,
                                        onPressed: () {
                                          ref
                                              .read(cartControllerProvider
                                                  .notifier)
                                              .decreaseQuantity(item.productId);
                                        },
                                        icon: const Icon(Iconsax.minus),
                                      ),
                                      Text('${item.quantity}',
                                          style: GoogleFonts.roboto(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                          iconSize: 15.sp,
                                          onPressed: () {
                                            ref
                                                .read(cartControllerProvider
                                                    .notifier)
                                                .increaseQuantity(
                                                    item.productId);
                                          },
                                          icon: Icon(Iconsax.add))
                                    ],
                                  ),
                                  trailing: Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w800)),
                                ),
                              );
                            },
                          );
                        },
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) =>
                            Center(child: Text('Error: $error')),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    child: Row(
                      children: [
                        Text(
                          'Subtotal:',
                          style: GoogleFonts.roboto(
                            fontSize: EshopTypography.onboadingbody,
                            fontWeight: EshopFontweight.regular,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        cartItems.when(
                          data: (items) => Text(
                            '\$${getTotalPrice(items).toStringAsFixed(2)}',
                            style: GoogleFonts.roboto(
                                fontSize: EshopTypography.onboadingbody,
                                fontWeight: EshopFontweight.bold),
                          ),
                          error: (error, stackTrace) {
                            return Text(
                              'Error: $error',
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            );
                          },
                          loading: () {
                            return Text(
                              '\$0.00',
                              style: GoogleFonts.roboto(
                                  fontSize: EshopTypography.onboadingbody,
                                  fontWeight: EshopFontweight.bold),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        FilledButton(
                            onPressed: () async {
                              final items =
                                  ref.read(cartProvider).asData?.value ?? [];
                              final totalPrice = getTotalPrice(items);
                              (totalPrice == 0)
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('No Item to Checkout')))
                                  : Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => ShippingScreen(
                                              amount: totalPrice,
                                              orderItems: items
                                                  .map((item) => OrderItem(
                                                        productId:
                                                            item.productId,
                                                        productName:
                                                            item.productName,
                                                        price: item.price,
                                                        quantity: item.quantity,
                                                      ))
                                                  .toList())));
                            },
                            style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.sp)),
                                backgroundColor: Appcolors.bottomNavActive),
                            child: Text(
                              'Checkout',
                              style: GoogleFonts.roboto(
                                fontSize: EshopTypography.onboadingbody,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}

//HomePage
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required TextEditingController searchcontroller,
    required CarouselSliderController carouselController,
    required this.imageList,
  })  : _searchcontroller = searchcontroller,
        _carouselController = carouselController;

  final TextEditingController _searchcontroller;
  final CarouselSliderController _carouselController;
  final List imageList;

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
                  CategoriesWidget(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Popular Products',
                            style: GoogleFonts.roboto(
                                fontSize: EshopTypography.subtext,
                                fontWeight: EshopFontweight.semibold)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListPage(),
                                ));
                          },
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
                  ProductWidget(productList: false),
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
class EshopAppBar extends ConsumerWidget {
  const EshopAppBar({
    super.key,
    required TextEditingController searchcontroller,
  }) : _searchcontroller = searchcontroller;

  final TextEditingController _searchcontroller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    return Row(
      children: [
        Flexible(
            child: SizedBox(
                width: 260.w,
                child: Searchbar(searchcontroller: _searchcontroller))),
        Badge(
            // label: Text('${cartItems.asData!.value.length}'),
            alignment: Alignment(0.25.sp, -0.4.sp),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
            )),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCartPage(),
                  ));
            },
            icon: Badge(
                label: Text('${cartItems.asData?.value.length}'),
                child: const Icon(Iconsax.bag_2)))
      ],
    );
  }
}

//Search bar
class Searchbar extends ConsumerWidget {
  const Searchbar({
    super.key,
    required TextEditingController searchcontroller,
  }) : _searchcontroller = searchcontroller;

  final TextEditingController _searchcontroller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onTap: () {
        showSearch(context: context, delegate: SearchProducts(ref));
      },
      controller: _searchcontroller,
      decoration: InputDecoration(
          prefixIcon: GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: SearchProducts(ref));
              },
              child: const Icon(Iconsax.search_normal_1)),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Search',
          hintStyle: GoogleFonts.roboto(
              fontSize: EshopTypography.onboadingbody,
              color: Appcolors.subtextColor)),
    );
  }
}

//Wishlist
class WishlistPage extends ConsumerWidget {
  final TextEditingController searchcontroller;
  const WishlistPage({super.key, required this.searchcontroller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EshopAppBar(searchcontroller: searchcontroller),
            Text(
              'My Wishlist',
              style: GoogleFonts.roboto(
                  fontSize: 20.sp, color: Appcolors.textColor),
            ),
            SizedBox(
              height: 20.h,
            ),
            wishlistItems.when(
              data: (items) {
                if (items.isEmpty) {
                  return Expanded(
                    child: Center(
                        child: Text(
                      'No items added to wishlist',
                      style: GoogleFonts.roboto(
                          color: Appcolors.iconColor,
                          fontSize: EshopTypography.onboadingbody),
                    )),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final WishlistItem item = items[index];
                        return ListTile(
                          onTap: () {
                            //     Navigator.push(
                            // context,
                            // MaterialPageRoute(
                            //   builder: (context) => ProductDetailsPage(),
                            //   settings: RouteSettings(arguments: items[index] as ProductModel),
                            // ));
                          },
                          leading: Container(
                            height: 50.h,
                            width: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              image: DecorationImage(
                                image: NetworkImage(item.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            item.productName,
                            style: GoogleFonts.roboto(fontSize: 14.sp),
                          ),
                          subtitle: item.oldPrice != null
                              ? Row(
                                  children: [
                                    Text(
                                      '\$${item.oldPrice?.toStringAsFixed(2)}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Appcolors.promptColor,
                                        color: Appcolors.promptColor,
                                        fontWeight: EshopFontweight.semibold,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      '\$${item.price.toStringAsFixed(2)}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                          fontWeight: EshopFontweight.bold),
                                    )
                                  ],
                                )
                              : Text('\$${item.price.toStringAsFixed(2)}',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      fontWeight: EshopFontweight.bold)),
                          trailing: IconButton(
                              onPressed: () {
                                ref
                                    .read(wishlistControllerProvider.notifier)
                                    .removeFromWishlist(item.productId);
                              },
                              icon: Icon(Iconsax.heart5,
                                  color: Appcolors.promptColor)),
                        );
                      }),
                );
              },
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      )),
    );
  }
}

//Profile page
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final TextEditingController searchcontroller = TextEditingController();
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
            style:
                GoogleFonts.roboto(fontSize: 20.sp, color: Appcolors.textColor),
          ),
          SizedBox(height: 30.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const AssetImage(EshopAssets.person) as ImageProvider,
                radius: 25.r,
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? 'User',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.onboadingbody,
                        fontWeight: EshopFontweight.medium),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(user?.email ?? '',
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
                    onpressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyOrdersScreen()));
                    },
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
                onpressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WishlistPage(
                            searchcontroller: searchcontroller,
                          )));
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              ProfileTile(
                icon: Iconsax.location,
                iconText: 'Delivery address',
                onpressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddedAddressScreen()));
                },
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
              SizedBox(
                height: 20.sp,
              ),
              ProfileTile(
                icon: Iconsax.logout,
                iconText: 'Logout',
                onpressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp)),
                        backgroundColor: Appcolors.backgroundColor,
                        title: Text('Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No')),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EshopSignInPage()));
                                debugPrint('${user?.displayName} Logged out');
                              },
                              child: Text('Yes'))
                        ],
                      );
                    },
                  );
                },
              )
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
