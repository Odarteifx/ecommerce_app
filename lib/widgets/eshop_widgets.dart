// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
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
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn
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
  const categoriesWidget({super.key});

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsbyCategoryPage(categoryname: data[index].name.toString()),));
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(), settings: RouteSettings(arguments: data[index]),));
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
                                  // setState(() {
                                  //   wishlist = !wishlist;
                                  // });
                                },
                                icon: const Icon(
                                  Iconsax.heart5,
                                  color: Appcolors.promptColor,
                                )
                                // : const Icon(
                                //   Iconsax.heart,
                                //   color: Appcolors.iconColor,
                                // )
                                )
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
      {super.key, required this.buttonText, required this.function, required this.color});

  final String buttonText;
  final VoidCallback function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 160.w,
      child: FilledButton(
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            backgroundColor: color),
        onPressed: function,
        child: Text(
          buttonText,
          style: GoogleFonts.roboto(
              fontSize: EshopTypography.onboadingbody,
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
   const RelatedProductsWidget({super.key, 
    required this.prodctname,
    required this.categoryname,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedProducts = ref.watch(getRelatedProductsProvider(categoryname));
    return relatedProducts.when(data: (data){
      final filteredData = data.where((product) => product.name != prodctname).toList();
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
                    return GestureDetector(
                      onTap: () {
                        print(filteredData.toList());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(), settings: RouteSettings(arguments: filteredData[index]),));
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
                                            fontSize:
                                                EshopTypography.homepagecategories,
                                            decoration: TextDecoration.lineThrough),
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
                                      // setState(() {
                                      //   wishlist = !wishlist;
                                      // });
                                    },
                                    icon: const Icon(
                                      Iconsax.heart5,
                                      color: Appcolors.promptColor,
                                    )
                                    // : const Icon(
                                    //   Iconsax.heart,
                                    //   color: Appcolors.iconColor,
                                    // )
                                    )
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
    }, error: (error, StackTrace)=> ErrorText(error: error.toString()), loading: ()=>Loader());
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
        child: IconButton(onPressed: (){
          query = '';
        }, icon: Icon(Iconsax.search_normal_1)),
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(), settings: RouteSettings(arguments: data[index]),));
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
                                  // setState(() {
                                  //   wishlist = !wishlist;
                                  // });
                                },
                                icon: const Icon(
                                  Iconsax.heart5,
                                  color: Appcolors.promptColor,
                                )
                                // : const Icon(
                                //   Iconsax.heart,
                                //   color: Appcolors.iconColor,
                                // )
                                )
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(), settings: RouteSettings(arguments: data[index]),));
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
                                  // setState(() {
                                  //   wishlist = !wishlist;
                                  // });
                                },
                                icon: const Icon(
                                  Iconsax.heart5,
                                  color: Appcolors.promptColor,
                                )
                                // : const Icon(
                                //   Iconsax.heart,
                                //   color: Appcolors.iconColor,
                                // )
                                )
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
