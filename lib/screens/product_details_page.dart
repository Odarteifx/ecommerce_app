import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/models/product_models.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          color: Appcolors.backgroundColor,
          child: AddToCartButton(buttonText: 'Add To Cart', function: () {})),
      backgroundColor: Appcolors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 30.h,),
            Stack(
              children: [
                Container(
                  height: 500.h,
                  decoration: BoxDecoration(color: Appcolors.widgetcolor),
                  child: Center(
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    top: 50.sp,
                    left: 5.sp,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_sharp))),
                Positioned(
                    top: 50.sp,
                    right: 5.sp,
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Iconsax.heart)),
                        IconButton(onPressed: () {}, icon: Icon(Iconsax.bag_2)),
                      ],
                    ))
              ],
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    product.categoryname,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  if (product.oldPrice != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${product.oldPrice?.toStringAsFixed(2)}',
                              style: GoogleFonts.roboto(
                                  fontWeight: EshopFontweight.medium,
                                  fontSize: EshopTypography.termsfont,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.info_outline,
                                  size: 18,
                                )),
                          ],
                        ),
                        Text(
                          '\$${product.price}',
                          style: GoogleFonts.roboto(
                              fontSize: EshopTypography.onboadingbody,
                              fontWeight: EshopFontweight.bold,
                              color: Appcolors.promptColor),
                        ),
                      ],
                    )
                  else
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                          fontSize: EshopTypography.onboadingbody,
                          fontWeight: EshopFontweight.bold,
                          color: Appcolors.textColor),
                    ),
                  Text(
                    product.name,
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.onboadingbody,
                        fontWeight: EshopFontweight.medium),
                  ),
                  Text(
                    product.description,
                    style: GoogleFonts.roboto(
                        fontSize: EshopTypography.subtext,
                        fontWeight: EshopFontweight.light),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Similar Products',
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
                     SizedBox(
                    height: 14.h,
                  ),
                  RelatedProductsWidget(categoryname: product.categoryname)
                  // AddToCart(buttonText: 'Add To Cart', function: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
