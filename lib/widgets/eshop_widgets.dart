import 'dart:math';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controllers/categories_controller.dart';
import 'package:ecommerce_app/fakedata.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/services/categories_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constants/eshop_assets.dart';
import '../constants/eshop_typography.dart';

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
                  borderRadius: BorderRadius.circular(5)),
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
              )),
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
class categoriesWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      child: ref.watch(getsProductsProvider).when(data: (data) => ListView.builder(
        itemBuilder: (context, index) {
        
      },),
       error: error, loading: loading)
    );
  }
  
}


// //Categories tile
// class Categoriestile extends StatelessWidget {
//   final String iconUrl;
//   final String iconName;

//   const Categoriestile({
//     super.key,
//     required this.iconUrl,
//     required this.iconName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60.h,
//       width: 150.w,
//       decoration: BoxDecoration(
//           color: Appcolors.widgetcolor,
//           borderRadius: BorderRadius.all(Radius.circular(10.sp))),
//       child: GestureDetector(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image(
//               image: AssetImage(iconUrl),
//               height: 30.h,
//             ),
//             SizedBox(
//               width: 8.w,
//             ),
//             Text(
//               iconName,
//               style: GoogleFonts.roboto(
//                   fontSize: EshopTypography.homepagecategories),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// // Categories section
// class CategoriesSection extends StatelessWidget {
//   const CategoriesSection({
//     super.key,
//     required this.iconList,
//   });

//   final List iconList;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//           children: iconList.map((iconData) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.w),
//           child: Categoriestile(
//               iconUrl: iconData['image_path'], iconName: iconData['iconName']),
//         );
//       }).toList()),
//     );
//   }
// }

// Item
class ItemTile extends StatefulWidget {
  final int indexx;
  const ItemTile(int index, {super.key, required this.indexx});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  late bool wishlist;

  @override
  void initState() {
    super.initState();
   wishlist = Fakedata.techProducts[widget.indexx].isWishlist; 
  }
  @override
  Widget build(BuildContext context,) {

    return Container(
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
            child: Image.asset(
              Fakedata.techProducts[widget.indexx].productAsset,
              width: 150.w,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Fakedata.techProducts[widget.indexx].productDiscount != null?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                          '\$${Fakedata.techProducts[widget.indexx].productDiscount}',
                          style: GoogleFonts.roboto(
                              fontWeight: EshopFontweight.medium,
                              fontSize: EshopTypography.homepagecategories,
                              decoration: TextDecoration.lineThrough),
                        ),
                  Text(
                    '\$${Fakedata.techProducts[widget.indexx].productPrice}',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.subtext,
                        fontWeight: EshopFontweight.medium,
                        color: Fakedata.techProducts[widget.indexx]
                                    .productDiscount ==
                                null
                            ? Appcolors.textColor
                            : Appcolors.promptColor),
                  ),
                ],
              ) : Text(
                    '\$${Fakedata.techProducts[widget.indexx].productPrice}',
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.onboadingbody,
                        fontWeight: EshopFontweight.medium,
                        color:  Appcolors.textColor
                        ),
                  ) ,
              IconButton(
                  onPressed: () {
                    setState(() {
                      wishlist = !wishlist;
                    });
                  },
                  icon: wishlist
                      ?
                      const Icon(
                          Iconsax.heart5,
                          color: Appcolors.promptColor,
                        ) : const Icon(
                          Iconsax.heart,
                          color: Appcolors.iconColor,
                        )
                      )
            ],
          ),
          Text(
            Fakedata.techProducts[widget.indexx].productName,
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
    );
  }
}

//Products layout
class PGridLayout extends StatelessWidget {
  const PGridLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Fakedata.techProducts.length,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.sp,
          mainAxisExtent: 250.sp),
      itemBuilder: (context, index) => ItemTile(index, indexx: index,),
    );
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
