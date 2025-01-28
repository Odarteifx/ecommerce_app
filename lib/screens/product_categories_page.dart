import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/screens/product_details_page.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/eshop_typography.dart';
import '../controllers/wishlist_controller.dart';
import '../models/wishlist_model.dart';

class ProductsbyCategoryPage extends ConsumerWidget {
  final String categoryname;
  const ProductsbyCategoryPage({required this.categoryname, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(getProductsbyCategoryProvider(categoryname));
    final wishlistItems = ref.watch(wishlistProvider);
    bool isInWishlist(int index) => wishlistItems.maybeWhen(
          data: (items) => items.any((item) =>
              item.productId == products.asData!.value[index].productId),
          orElse: () => false,
        );
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          title: Text(categoryname),
          backgroundColor: Appcolors.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: products.when(
              data: (data) {
                return data.isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          GridView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                          builder: (context) =>
                                              ProductDetailsPage(),
                                          settings: RouteSettings(
                                              arguments: data[index]),
                                        ));
                                  },
                                  child: Container(
                                    height: 245.h,
                                    width: 165.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 165.sp,
                                          width: 165.w,
                                          decoration: BoxDecoration(
                                              color: Appcolors.widgetcolor,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp)),
                                          child: Image.network(
                                            data[index].image.toString(),
                                            width: 150.w,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (data[index].oldPrice != null)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '\$${data[index].oldPrice?.toStringAsFixed(2)}',
                                                    style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            EshopFontweight
                                                                .medium,
                                                        fontSize: EshopTypography
                                                            .homepagecategories,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  Text(
                                                    '\$${data[index].price}',
                                                    style: GoogleFonts.roboto(
                                                        fontSize:
                                                            EshopTypography
                                                                .subtext,
                                                        fontWeight:
                                                            EshopFontweight
                                                                .medium,
                                                        color: Appcolors
                                                            .promptColor),
                                                  ),
                                                ],
                                              )
                                            else
                                              Text(
                                                '\$${data[index].price.toStringAsFixed(2)}',
                                                style: GoogleFonts.roboto(
                                                    fontSize: EshopTypography
                                                        .onboadingbody,
                                                    fontWeight:
                                                        EshopFontweight.medium,
                                                    color: Appcolors.textColor),
                                              ),
                                            IconButton(
                                                onPressed: () {
                                                  if (isInWishlistFlag) {
                                                    final wishlistItem =
                                                        wishlistItems
                                                            .value!
                                                            .firstWhere((item) =>
                                                                item.productId ==
                                                                data[index]
                                                                    .productId);
                                                    ref
                                                        .read(
                                                            wishlistControllerProvider
                                                                .notifier)
                                                        .removeFromWishlist(
                                                            wishlistItem
                                                                .productId);
                                                  } else {
                                                    final wishlistItem =
                                                        WishlistItem(
                                                            productId:
                                                                data[index]
                                                                    .productId,
                                                            image: data[index]
                                                                .image,
                                                            productName:
                                                                data[index]
                                                                    .name,
                                                            price: data[index]
                                                                .price,
                                                            oldPrice:
                                                                data[index]
                                                                    .oldPrice);
                                                    ref
                                                        .read(
                                                            wishlistControllerProvider
                                                                .notifier)
                                                        .addToWishlist(
                                                            wishlistItem);
                                                  }
                                                },
                                                icon: Icon(
                                                    isInWishlistFlag
                                                        ? Iconsax.heart5
                                                        : Iconsax.heart,
                                                    color: isInWishlistFlag
                                                        ? Appcolors.promptColor
                                                        : Appcolors.textColor))
                                          ],
                                        ),
                                        Text(
                                          '${data[index].name} - ${data[index].description}',
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: GoogleFonts.roboto(
                                              color: Appcolors.subtextColor,
                                              fontSize: EshopTypography
                                                  .homepagecategories,
                                              fontWeight:
                                                  EshopFontweight.regular),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      )
                    : Center(
                        child: Text(
                          'No Products Available',
                          style: GoogleFonts.roboto(
                              color: Appcolors.iconColor,
                              fontSize: EshopTypography.onboadingbody),
                        ),
                      );
              },
              error: (error, StackTrace) => ErrorWidget(error.toString()),
              loading: () => Loader()),
        ));
  }
}
