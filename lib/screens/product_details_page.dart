import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/wishlist_controller.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:ecommerce_app/models/product_models.dart';
import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:ecommerce_app/screens/homepage.dart';
import 'package:ecommerce_app/screens/shipping_screen.dart';
import 'package:ecommerce_app/widgets/eshop_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    final wishlistItems = ref.watch(wishlistProvider);
    final cartItems = ref.watch(cartProvider);

    bool isInWishlist = wishlistItems.maybeWhen(
      data: (items) => items.any((item) => item.productId == product.productId),
      orElse: () => false,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                if (isInWishlist) {
                  final wishlistItem = wishlistItems.value!.firstWhere(
                      (item) => item.productId == product.productId);
                  ref
                      .read(wishlistControllerProvider.notifier)
                      .removeFromWishlist(wishlistItem.productId);
                } else {
                  final wishlistItem = WishlistItem(
                      productId: product.productId,
                      image: product.image,
                      productName: product.name,
                      price: product.price,
                      oldPrice: product.oldPrice);
                  ref
                      .read(wishlistControllerProvider.notifier)
                      .addToWishlist(wishlistItem);
                }
              },
              icon: Icon(isInWishlist ? Iconsax.heart5 : Iconsax.heart,
                  color: isInWishlist
                      ? Appcolors.promptColor
                      : Appcolors.textColor)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyCartPage(),
                ));
              },
              icon: Badge(
                  label: Text('${cartItems.asData?.value.length}'),
                  child: Icon(Iconsax.bag_2))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Appcolors.backgroundColor,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ProductActionButton(
              buttonText: 'Add To Cart',
              function: () {
                final cartItem = CartItem(
                  quantity: 1,
                  productId: product.productId,
                  image: product.image,
                  productName: product.name,
                  oldPrice: product.oldPrice,
                  price: product.price,
                );
                ref.read(cartControllerProvider.notifier).addToCart(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} Added to Cart')),
                );
              },
              color: Appcolors.backgroundColor,
              textColorcolor: Appcolors.bottomNavActive,
              borderColor: Appcolors.bottomNavActive,
            ),
            ProductActionButton(
              buttonText: 'Buy Now',
              function: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ShippingScreen(amount: product.price, orderItems: [
                            OrderItem(
                                productId: product.productId,
                                productName: product.name,
                                price: product.price,
                                quantity: 1)
                          ])),
                );
              },
              color: Appcolors.bottomNavActive,
              textColorcolor: Appcolors.backgroundColor,
              borderColor: Appcolors.bottomNavActive,
            )
          ])),
      backgroundColor: Appcolors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.h,
              child: Center(
                child: Image.network(
                  product.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5.h),
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
                    style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: EshopFontweight.regular,
                        color: Appcolors.subtextColor),
                  ),
                  SizedBox(
                    height: 3.h,
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
                              width: 3.w,
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.info_outline,
                                  size: 15.sp,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description,
                          maxLines: isExpanded ? null : 4,
                          overflow: isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              fontSize: EshopTypography.termsfont,
                              fontWeight: EshopFontweight.light),
                        ),
                        Text(
                          isExpanded ? 'Read less' : 'Read more',
                          style: TextStyle(
                              color: Appcolors.primaryColor,
                              fontSize: EshopTypography.subtext,
                              fontWeight: EshopFontweight.light),
                        ),
                      ],
                    ),
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
                  RelatedProductsWidget(
                    categoryname: product.categoryname,
                    prodctname: product.name,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
