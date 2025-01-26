// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/controllers/wishlist_controller.dart';
import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:ecommerce_app/services/address_services.dart';
import 'package:ecommerce_app/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controllers/categories_controller.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/screens/product_categories_page.dart';

import '../constants/eshop_assets.dart';
import '../constants/eshop_typography.dart';
import '../controllers/address_controller.dart';
import '../models/shipping_model.dart';
import '../screens/product_details_page.dart';

//Onboarding and pageview Images
class OnboardingAsset extends StatelessWidget {
  final String imagePath;
  const OnboardingAsset({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: 390.w,
      height: 390.h,
    );
  }
}

//Eshop logo
class EshopLogo extends StatelessWidget {
  const EshopLogo({super.key, required this.logoColor});

  final Color logoColor;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'eSh',
          style: GoogleFonts.roboto(
            fontStyle: FontStyle.italic,
            fontSize: EshopTypography.heading1,
            letterSpacing: EshopTypography.heading1 * -0.05,
            color: logoColor,
            fontWeight: EshopFontweight.semibold,
          ),
        ),
        Text(
          'op',
          style: GoogleFonts.roboto(
            fontStyle: FontStyle.italic,
            fontSize: EshopTypography.heading1,
            letterSpacing: EshopTypography.heading1 * -0.05,
            color: logoColor,
            fontWeight: EshopFontweight.semibold,
            decoration: TextDecoration.underline,
            decorationColor: logoColor,
            decorationThickness: 1.5.sp,
          ),
        ),
      ],
    );
  }
}

// MajorButttons - Get Started, Signin, Signup btns
class MajorButton extends StatelessWidget {
  const MajorButton(
      {super.key, required this.buttonText, required this.function});

  final String buttonText;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: SizedBox(
        height: 50.h,
        width: double.infinity,
        child: FilledButton(
          style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.sp)),
              backgroundColor: Appcolors.primaryColor),
          onPressed: function,
          child: Text(
            buttonText,
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.subtext,
                fontWeight: EshopFontweight.medium),
          ),
        ),
      ),
    );
  }
}

//Signin background stack
class SigninStack extends StatelessWidget {
  const SigninStack({super.key, required this.pagecontent});

  final Widget pagecontent;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: -80.h,
            left: -90.w,
            child: Transform.rotate(
                angle: pi / -22.3, child: Image.asset(EshopAssets.signinup))),
        Positioned(
            top: 744.h,
            left: 257.w,
            child: Image.asset(EshopAssets.signindown)),
        SafeArea(child: pagecontent)
      ],
    );
  }
}

//Page headding text
class PageHeading extends StatelessWidget {
  const PageHeading({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: EshopTypography.heading2,
        fontWeight: EshopFontweight.semibold,
      ),
    );
  }
}

//subtext
class SubText extends StatelessWidget {
  const SubText({super.key, required this.subtext});

  final String subtext;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtext,
      style: GoogleFonts.roboto(
          fontSize: EshopTypography.subtext,
          fontWeight: EshopFontweight.regular,
          color: Appcolors.subtextColor),
    );
  }
}

//note beneath login/singup page
class UnderNote extends StatelessWidget {
  const UnderNote(
      {super.key,
      required this.questionText,
      required this.actionText,
      required this.function});

  final String questionText;
  final String actionText;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          questionText,
          style: GoogleFonts.roboto(
              fontSize: EshopTypography.subtext,
              fontWeight: EshopFontweight.regular,
              color: Appcolors.subtextColor),
        ),
        Container(
          color: Appcolors.backgroundColor,
          child: InkWell(
            onTap: function,
            child: Text(
              actionText,
              style: GoogleFonts.roboto(
                  fontSize: EshopTypography.subtext,
                  fontWeight: EshopFontweight.medium,
                  color: Appcolors.primaryColor),
            ),
          ),
        )
      ],
    );
  }
}

// App signin btns
class SigninIcon extends StatelessWidget {
  const SigninIcon({super.key, required this.iconUrl, required this.function});
  final String iconUrl;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.h,
        width: 150.w,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Appcolors.widgetcolor,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Appcolors.iconColor, width: 1),
                  borderRadius: BorderRadius.circular(15))),
          onPressed: function,
          child: Image.asset(
            iconUrl,
            height: 25.h,
          ),
        ));
  }
}

//email textfield
class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your email address';
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Enter email address',
          filled: true,
          fillColor: Appcolors.backgroundColor,
          hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.iconColor))),
    );
  }
}

// Full Name Textfield
class NameTextField extends StatelessWidget {
  final TextEditingController controller;

  const NameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your name';
        } else {
          return null;
        }
      },
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: 'Full Name',
          filled: true,
          fillColor: Appcolors.backgroundColor,
          hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.iconColor))),
    );
  }
}

// Password textfield
class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

bool _hidepassword = true;

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter a valid password';
        } else {
          return null;
        }
      },
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _hidepassword,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          hintText: widget.hintText,
          filled: true,
          fillColor: Appcolors.backgroundColor,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hidepassword = !_hidepassword;
              });
            },
            icon: Icon(
              _hidepassword ? Iconsax.eye : Iconsax.eye_slash,
              color: Appcolors.subtextColor,
            ),
          ),
          hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Appcolors.iconColor))),
    );
  }
}

//Terms & Conditions
class EshopTermsConditions extends ConsumerStatefulWidget {
  const EshopTermsConditions({super.key});

  @override
  ConsumerState<EshopTermsConditions> createState() =>
      _EshopTermsConditionsState();
}

class _EshopTermsConditionsState extends ConsumerState<EshopTermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: ref.watch(termsProvdier),
          onChanged: (value) {
            ref.read(termsProvdier.notifier).state = value!;
          },
        ),
        Wrap(
          children: [
            Text(
              'I agree to the ',
              style: GoogleFonts.roboto(
                  color: Appcolors.subtextColor,
                  fontSize: EshopTypography.termsfont,
                  fontWeight: EshopFontweight.regular),
            ),
            Text(
              'Terms of Service ',
              style: GoogleFonts.roboto(
                  color: Appcolors.primaryColor,
                  fontSize: EshopTypography.termsfont,
                  fontWeight: EshopFontweight.medium),
            ),
            Text(
              'and ',
              style: GoogleFonts.roboto(
                  color: Appcolors.subtextColor,
                  fontSize: EshopTypography.termsfont,
                  fontWeight: EshopFontweight.regular),
            ),
            Text(
              'Privacy Policy. ',
              style: GoogleFonts.roboto(
                  color: Appcolors.primaryColor,
                  fontSize: EshopTypography.termsfont,
                  fontWeight: EshopFontweight.medium),
            ),
          ],
        ),
      ],
    );
  }
}

//BannerWidget
class BannerWidget extends StatelessWidget {
  BannerWidget({
    super.key,
    required this.imageUrl,
    this.onpressed,
  });

  final String imageUrl;
  final VoidCallback? onpressed;
  final double borderRadius = 10.sp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 175.h,
        width: 350.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}

//banner slider
class BannerSlider extends StatelessWidget {
  const BannerSlider({
    super.key,
    required CarouselSliderController carouselController,
    required this.imageList,
  }) : _carouselController = carouselController;

  final CarouselSliderController _carouselController;
  final List imageList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 175.sp,
          width: 350.w,
          child: CarouselSlider(
              carouselController: _carouselController,
              items: imageList.map((image) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h),
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
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn)),
        ),
        Positioned(
            left: 160.sp,
            top: 165.sp,
            child: Row(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: bannerIndexNotifier,
                  builder: (BuildContext context, bannerindex, Widget? child) {
                    return SmoothPageIndicator(
                      controller: PageController(initialPage: bannerindex),
                      onDotClicked: (index) {
                        _carouselController.animateToPage(index);
                      },
                      count: 3,
                      effect: ExpandingDotsEffect(
                          dotColor: Appcolors.iconColor,
                          activeDotColor: Appcolors.primaryColor,
                          dotWidth: 6.w,
                          dotHeight: 2.h,
                          spacing: 6.w),
                    );
                  },
                ),
              ],
            )),
      ],
    );
  }
}

//categories with firebase
class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        height: 60.h,
        child: ref.watch(getsCategoriesProvider).when(
            data: (data) => ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsbyCategoryPage(
                                    categoryname: data[index].name.toString()),
                              ));
                        },
                        child: Container(
                          height: 60.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: Appcolors.widgetcolor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.sp))),
                          child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImage(
                                      data[index].image.toString()),
                                  height: 30.h,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  data[index].name.toString(),
                                  style: GoogleFonts.roboto(
                                      fontSize:
                                          EshopTypography.homepagecategories),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            error: (error, StackTrace) => ErrorText(
                  error: error.toString(),
                ),
            loading: () => Loader()));
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({
    super.key,
    required this.error,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}

class ProductWidget extends ConsumerWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(getsProductsProvider);
    final wishlistItems = ref.watch(wishlistProvider);
    bool isInWishlist(int index) => wishlistItems.maybeWhen(
          data: (items) => items.any((item) =>
              item.productId == product.asData!.value[index].productId),
          orElse: () => false,
        );
    return product.when(
        data: (data) {
          return GridView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 20.sp,
                  mainAxisExtent: 250.sp),
              itemBuilder: (context, index) {
                bool isInWishlistFlag = isInWishlist(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(),
                          settings: RouteSettings(arguments: data[index]),
                        ));
                  },
                  child: Container(
                    height: 245.h,
                    width: 165.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 165.sp,
                          width: 165.w,
                          decoration: BoxDecoration(
                              color: Appcolors.widgetcolor,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Image.network(
                            data[index].image.toString(),
                            width: 150.w,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (data[index].oldPrice != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${data[index].oldPrice?.toStringAsFixed(2)}',
                                    style: GoogleFonts.roboto(
                                        fontWeight: EshopFontweight.medium,
                                        fontSize:
                                            EshopTypography.homepagecategories,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    '\$${data[index].price}',
                                    style: GoogleFonts.roboto(
                                        fontSize: EshopTypography.subtext,
                                        fontWeight: EshopFontweight.medium,
                                        color: Appcolors.promptColor),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '\$${data[index].price.toStringAsFixed(2)}',
                                style: GoogleFonts.roboto(
                                    fontSize: EshopTypography.onboadingbody,
                                    fontWeight: EshopFontweight.medium,
                                    color: Appcolors.textColor),
                              ),
                            IconButton(
                                onPressed: () {
                                  print('${wishlistItems}');
                                  if (isInWishlistFlag) {
                                    final wishlistItem = wishlistItems.value!
                                        .firstWhere((item) =>
                                            item.productId ==
                                            data[index].productId);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .removeFromWishlist(
                                            wishlistItem.productId);
                                  } else {
                                    final wishlistItem = WishlistItem(
                                        productId: data[index].productId,
                                        image: data[index].image,
                                        productName: data[index].name,
                                        price: data[index].price,
                                        oldPrice: data[index].oldPrice);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .addToWishlist(wishlistItem);
                                  }
                                },
                                icon: Icon(
                                    isInWishlistFlag
                                        ? Iconsax.heart5
                                        : Iconsax.heart,
                                    color: isInWishlistFlag
                                        ? Appcolors.promptColor
                                        : Appcolors.textColor)),
                          ],
                        ),
                        Text(
                          '${data[index].name} - ${data[index].description}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                              color: Appcolors.subtextColor,
                              fontSize: EshopTypography.homepagecategories,
                              fontWeight: EshopFontweight.regular),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        error: (error, StackTrace) => ErrorWidget('Error: $error'),
        loading: () => Loader());
  }
}

//Profile Widgets
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
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
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        width: 170.w,
        height: 40.sp,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolors.iconColor),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Appcolors.subtextColor,
            ),
            SizedBox(
              width: 10.w,
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
      ),
    );
  }
}

class ProductActionButton extends StatelessWidget {
  const ProductActionButton(
      {super.key,
      required this.buttonText,
      required this.function,
      required this.color,
      required this.textColorcolor,
      required this.borderColor});

  final String buttonText;
  final VoidCallback function;
  final Color color;
  final Color borderColor;
  final Color textColorcolor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 150.w,
      child: FilledButton(
        style: FilledButton.styleFrom(
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.sp)),
            backgroundColor: color),
        onPressed: function,
        child: Text(
          buttonText,
          style: GoogleFonts.roboto(
              //fontSize: EshopTypography.onboadingbody,
              color: textColorcolor,
              fontWeight: EshopFontweight.medium),
        ),
      ),
    );
  }
}

//Related Products Widget
class RelatedProductsWidget extends ConsumerWidget {
  final String prodctname;
  final String categoryname;
  const RelatedProductsWidget({
    super.key,
    required this.prodctname,
    required this.categoryname,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedProducts = ref.watch(getRelatedProductsProvider(categoryname));
    final wishlistItems = ref.watch(wishlistProvider);
    bool isInWishlist(int index) => wishlistItems.maybeWhen(
          data: (items) => items.any((item) =>
              item.productId == relatedProducts.asData!.value[index].productId),
          orElse: () => false,
        );
    return relatedProducts.when(
        data: (data) {
          final filteredData =
              data.where((product) => product.name != prodctname).toList();
          return Container(
            child: GridView.builder(
                itemCount: filteredData.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 0.h),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.sp,
                    mainAxisExtent: 250.sp),
                itemBuilder: (context, index) {
                  bool isInWishlistFlag = isInWishlist(index);
                  return GestureDetector(
                    onTap: () {
                      print(filteredData.toList());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(),
                            settings:
                                RouteSettings(arguments: filteredData[index]),
                          ));
                    },
                    child: Container(
                      height: 245.h,
                      width: 165.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165.sp,
                            width: 165.w,
                            decoration: BoxDecoration(
                                color: Appcolors.widgetcolor,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Image.network(
                              filteredData[index].image.toString(),
                              width: 150.w,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (filteredData[index].oldPrice != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$${filteredData[index].oldPrice?.toStringAsFixed(2)}',
                                      style: GoogleFonts.roboto(
                                          fontWeight: EshopFontweight.medium,
                                          fontSize: EshopTypography
                                              .homepagecategories,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      '\$${filteredData[index].price}',
                                      style: GoogleFonts.roboto(
                                          fontSize: EshopTypography.subtext,
                                          fontWeight: EshopFontweight.medium,
                                          color: Appcolors.promptColor),
                                    ),
                                  ],
                                )
                              else
                                Text(
                                  '\$${filteredData[index].price.toStringAsFixed(2)}',
                                  style: GoogleFonts.roboto(
                                      fontSize: EshopTypography.onboadingbody,
                                      fontWeight: EshopFontweight.medium,
                                      color: Appcolors.textColor),
                                ),
                              IconButton(
                                  onPressed: () {
                                    print('${wishlistItems}');
                                    if (isInWishlistFlag) {
                                      final wishlistItem = wishlistItems.value!
                                          .firstWhere((item) =>
                                              item.productId ==
                                              filteredData[index].productId);
                                      ref
                                          .read(wishlistControllerProvider
                                              .notifier)
                                          .removeFromWishlist(
                                              wishlistItem.productId);
                                    } else {
                                      final wishlistItem = WishlistItem(
                                          productId:
                                              filteredData[index].productId,
                                          image: filteredData[index].image,
                                          productName: filteredData[index].name,
                                          price: filteredData[index].price,
                                          oldPrice:
                                              filteredData[index].oldPrice);
                                      ref
                                          .read(wishlistControllerProvider
                                              .notifier)
                                          .addToWishlist(wishlistItem);
                                    }
                                  },
                                  icon: Icon(
                                      isInWishlistFlag
                                          ? Iconsax.heart5
                                          : Iconsax.heart,
                                      color: isInWishlistFlag
                                          ? Appcolors.promptColor
                                          : Appcolors.textColor)),
                            ],
                          ),
                          Text(
                            '${filteredData[index].name} - ${filteredData[index].description}',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                                color: Appcolors.subtextColor,
                                fontSize: EshopTypography.homepagecategories,
                                fontWeight: EshopFontweight.regular),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => Loader());
  }
}

//Search Widget
class SearchProducts extends SearchDelegate {
  final WidgetRef ref;
  SearchProducts(this.ref);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Iconsax.search_normal_1)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final product = ref.watch(searchProductsProvider(query));
    final wishlistItems = ref.watch(wishlistProvider);
    bool isInWishlist(int index) => wishlistItems.maybeWhen(
          data: (items) => items.any((item) =>
              item.productId == product.asData!.value[index].productId),
          orElse: () => false,
        );
    return product.when(
        data: (data) {
          return GridView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 20.sp,
                  mainAxisExtent: 250.sp),
              itemBuilder: (context, index) {
                bool isInWishlistFlag = isInWishlist(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(),
                          settings: RouteSettings(arguments: data[index]),
                        ));
                  },
                  child: Container(
                    height: 245.h,
                    width: 165.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 165.sp,
                          width: 165.w,
                          decoration: BoxDecoration(
                              color: Appcolors.widgetcolor,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Image.network(
                            data[index].image.toString(),
                            width: 150.w,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (data[index].oldPrice != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${data[index].oldPrice?.toStringAsFixed(2)}',
                                    style: GoogleFonts.roboto(
                                        fontWeight: EshopFontweight.medium,
                                        fontSize:
                                            EshopTypography.homepagecategories,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    '\$${data[index].price}',
                                    style: GoogleFonts.roboto(
                                        fontSize: EshopTypography.subtext,
                                        fontWeight: EshopFontweight.medium,
                                        color: Appcolors.promptColor),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '\$${data[index].price.toStringAsFixed(2)}',
                                style: GoogleFonts.roboto(
                                    fontSize: EshopTypography.onboadingbody,
                                    fontWeight: EshopFontweight.medium,
                                    color: Appcolors.textColor),
                              ),
                            IconButton(
                                onPressed: () {
                                  print('${wishlistItems}');
                                  if (isInWishlistFlag) {
                                    final wishlistItem = wishlistItems.value!
                                        .firstWhere((item) =>
                                            item.productId ==
                                            data[index].productId);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .removeFromWishlist(
                                            wishlistItem.productId);
                                  } else {
                                    final wishlistItem = WishlistItem(
                                        productId: data[index].productId,
                                        image: data[index].image,
                                        productName: data[index].name,
                                        price: data[index].price,
                                        oldPrice: data[index].oldPrice);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .addToWishlist(wishlistItem);
                                  }
                                },
                                icon: Icon(
                                    isInWishlistFlag
                                        ? Iconsax.heart5
                                        : Iconsax.heart,
                                    color: isInWishlistFlag
                                        ? Appcolors.promptColor
                                        : Appcolors.textColor)),
                          ],
                        ),
                        Text(
                          '${data[index].name} - ${data[index].description}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                              color: Appcolors.subtextColor,
                              fontSize: EshopTypography.homepagecategories,
                              fontWeight: EshopFontweight.regular),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        error: (error, StackTrace) => ErrorWidget(error.toString()),
        loading: () => Loader());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final product = ref.watch(searchProductsProvider(query));
    final wishlistItems = ref.watch(wishlistProvider);
    bool isInWishlist(int index) => wishlistItems.maybeWhen(
          data: (items) => items.any((item) =>
              item.productId == product.asData!.value[index].productId),
          orElse: () => false,
        );
    return product.when(
        data: (data) {
          return GridView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 20.sp,
                  mainAxisExtent: 250.sp),
              itemBuilder: (context, index) {
                bool isInWishlistFlag = isInWishlist(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(),
                          settings: RouteSettings(arguments: data[index]),
                        ));
                  },
                  child: Container(
                    height: 245.h,
                    width: 165.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 165.sp,
                          width: 165.w,
                          decoration: BoxDecoration(
                              color: Appcolors.widgetcolor,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Image.network(
                            data[index].image.toString(),
                            width: 150.w,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (data[index].oldPrice != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\$${data[index].oldPrice?.toStringAsFixed(2)}',
                                    style: GoogleFonts.roboto(
                                        fontWeight: EshopFontweight.medium,
                                        fontSize:
                                            EshopTypography.homepagecategories,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    '\$${data[index].price}',
                                    style: GoogleFonts.roboto(
                                        fontSize: EshopTypography.subtext,
                                        fontWeight: EshopFontweight.medium,
                                        color: Appcolors.promptColor),
                                  ),
                                ],
                              )
                            else
                              Text(
                                '\$${data[index].price.toStringAsFixed(2)}',
                                style: GoogleFonts.roboto(
                                    fontSize: EshopTypography.onboadingbody,
                                    fontWeight: EshopFontweight.medium,
                                    color: Appcolors.textColor),
                              ),
                            IconButton(
                                onPressed: () {
                                  print('${wishlistItems}');
                                  if (isInWishlistFlag) {
                                    final wishlistItem = wishlistItems.value!
                                        .firstWhere((item) =>
                                            item.productId ==
                                            data[index].productId);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .removeFromWishlist(
                                            wishlistItem.productId);
                                  } else {
                                    final wishlistItem = WishlistItem(
                                        productId: data[index].productId,
                                        image: data[index].image,
                                        productName: data[index].name,
                                        price: data[index].price,
                                        oldPrice: data[index].oldPrice);
                                    ref
                                        .read(
                                            wishlistControllerProvider.notifier)
                                        .addToWishlist(wishlistItem);
                                  }
                                },
                                icon: Icon(
                                    isInWishlistFlag
                                        ? Iconsax.heart5
                                        : Iconsax.heart,
                                    color: isInWishlistFlag
                                        ? Appcolors.promptColor
                                        : Appcolors.textColor)),
                          ],
                        ),
                        Text(
                          '${data[index].name} - ${data[index].description}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.roboto(
                              color: Appcolors.subtextColor,
                              fontSize: EshopTypography.homepagecategories,
                              fontWeight: EshopFontweight.regular),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        error: (error, StackTrace) => ErrorWidget(error.toString()),
        loading: () => Loader());
  }
}

//Paystack Payment Method Component
final _stateChannel = StateProvider<Channels>((ref) => Channels.mobile_money);

class PaymentMethod extends ConsumerWidget {
  final ValueChanged<Channels> onselectedChannel;
  const PaymentMethod({super.key, required this.onselectedChannel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(_stateChannel);
    return SizedBox(
      height: 200.h,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Proceed to Payment',
            style: GoogleFonts.roboto(
                fontSize: EshopTypography.heading2,
                fontWeight: EshopFontweight.semibold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              channelWidget(
                context,
                ref,
                Channels.mobile_money,
                channel == Channels.mobile_money
                    ? Appcolors.primaryColor
                    : Appcolors.widgetcolor,
              ),
              channelWidget(
                  context,
                  ref,
                  Channels.card,
                  channel == Channels.card
                      ? Appcolors.primaryColor
                      : Appcolors.widgetcolor),
            ],
          ))
        ],
      ),
    );
  }

  InkWell channelWidget(
    BuildContext context,
    WidgetRef ref,
    Channels channel,
    Color color,
  ) {
    return InkWell(
        onTap: () {
          onselectedChannel(channel);
          ref.read(_stateChannel.notifier).update((state) => channel);
        },
        child: Card(
          color: color,
          child: Text(
            channel.name.split('_').join(' ').toUpperCase(),
            style: GoogleFonts.roboto(fontSize: EshopTypography.onboadingbody),
          ),
        ));
  }
}

//Shipping address form
class ShippingForm extends ConsumerStatefulWidget {
  const ShippingForm(
    this.addnewAddress, {
    super.key,
  });
  final bool addnewAddress;

  @override
  ConsumerState<ShippingForm> createState() => _ShippingFormState();
}

@override
class _ShippingFormState extends ConsumerState<ShippingForm> {
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  late final AddressServices ship;
  late final _formkey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _addressLineController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _countryController;
  late String _selectedCountry;

  bool _isEditable = true;
  bool _saveAddress = true;

  final Map<String, dynamic> _countries = {
    'Ghana': '🇬🇭',
    'Niger': '🇳🇪',
    'Nigeria': '🇳🇬',
    'Burkina Faso': '🇧🇫',
    'Cote ďIvoire': '🇨🇮',
    'Benin': '🇧🇯',
    'Guinea': '🇬🇳',
    'Gabon': '🇬🇦',
    'Mali': '🇲🇱',
    'Liberia': '🇱🇷',
    'Togo': '🇹🇬',
  };

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _addressLineController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController();
    _selectedCountry = '';
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _cityController.dispose();
    _addressLineController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        _isEditable == true ? _isEditable = false : _isEditable = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in your address details'),
        ),
      );
    }

    final email = userEmail;
    final fullName = _fullNameController.text;
    final phoneNumber = _phoneNumberController.text;
    final addressLine = _addressLineController.text;
    final city = _cityController.text;
    final state = _stateController.text;
    final country = _countryController.text;

    if (!_isEditable) {
      debugPrint('Email: $email');
      debugPrint('Full Name: $fullName');
      debugPrint('Phone Number: $phoneNumber');
      debugPrint('Address Line: $addressLine');
      debugPrint('City: $city');
      debugPrint('State: $state');
      debugPrint('Country: $country');
      try {
        final shippingAddress = ShippingAddress(
          fullName: fullName,
          phoneNumber: phoneNumber,
          addressLine: addressLine,
          state: state,
          city: city,
          country: country,
        );

        if (_saveAddress == true) {
          await ref
              .read(addressControllerProvider.notifier)
              .addShippingAddress(shippingAddress);
          debugPrint('Address saved successfully ;)');
        } else {
          debugPrint('Shipping Address Not Saved');
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          spacing: 6.sp,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Contact Information',
                style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: EshopFontweight.bold,
                    color: Appcolors.textColor)),
            TextFormField(
              decoration: InputDecoration(
                enabled: false,
                hintText: userEmail,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Text('Shipping Address',
                style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    fontWeight: EshopFontweight.bold,
                    color: Appcolors.textColor)),
            TextFormField(
              controller: _fullNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                enabled: _isEditable,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolors.iconColor)),
                hintText: 'Full Name',
                hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
              ),
            ),
            TextFormField(
              controller: _phoneNumberController,
              validator: (value) {
                if (value!.isEmpty || value.length < 10) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                enabled: _isEditable,
                hintText: 'Phone Number',
                hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolors.iconColor)),
              ),
            ),
            TextFormField(
              controller: _addressLineController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a your address';
                }
                return null;
              },
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                enabled: _isEditable,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolors.iconColor)),
                hintText: 'Address Line',
                hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
              ),
            ),
            TextFormField(
              controller: _cityController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your city';
                }
                return null;
              },
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                enabled: _isEditable,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolors.iconColor)),
                hintText: 'City',
                hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
              ),
            ),
            TextFormField(
              controller: _stateController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                enabled: _isEditable,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.iconColor),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolors.iconColor)),
                hintText: 'State',
                hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
              ),
            ),
            Autocomplete<String>(
              optionsMaxHeight: 4,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return _countries.keys.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _selectedCountry = selection;
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    enabled: _isEditable,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Appcolors.iconColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.iconColor)),
                    hintText: 'Country',
                    prefix: _selectedCountry.isNotEmpty? Text(
                      _countries[_selectedCountry][1]
                    ) : null,
                    hintStyle:
                        GoogleFonts.roboto(color: Appcolors.subtextColor),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your country';
                    }
                    return null;
                  },
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            // TextFormField(
            //   focusNode: FocusNode(),
            //   controller: _countryController,
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Please select your country';
            //     }
            //     return null;
            //   },
            // decoration: InputDecoration(
            //   enabled: _isEditable,
            //   border: OutlineInputBorder(
            //     borderSide: BorderSide(color: Appcolors.iconColor),
            //   ),
            //   enabledBorder: const OutlineInputBorder(
            //       borderSide: BorderSide(color: Appcolors.iconColor)),
            //   hintText: 'Country',
            //   hintStyle: GoogleFonts.roboto(color: Appcolors.subtextColor),
            // ),
            // ),
            widget.addnewAddress
                ? Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.sp,
                              child: FilledButton(
                                  onPressed: () {
                                    _handleSave();
                                  },
                                  style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.sp)),
                                      backgroundColor:
                                          Appcolors.bottomNavActive),
                                  child: Text(
                                    _isEditable ? 'Save Address' : 'Edit',
                                    style: GoogleFonts.roboto(
                                        fontSize:
                                            EshopTypography.onboadingbody),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Checkbox(
                          value: _saveAddress,
                          onChanged: (value) {
                            setState(() {
                              _saveAddress = value!;
                            });
                          }),
                      Text('Add to Default',
                          style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: EshopFontweight.regular,
                              color: Appcolors.textColor)),
                      Expanded(child: SizedBox()),
                      FilledButton(
                          onPressed: () {
                            _handleSave();
                          },
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp)),
                              backgroundColor: Appcolors.bottomNavActive),
                          child: Text(
                            _isEditable ? 'Save' : 'Edit',
                            style: GoogleFonts.roboto(
                                fontSize: EshopTypography.subtext),
                          )),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
