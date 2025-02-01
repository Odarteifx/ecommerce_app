import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../models/order_models/order_track.dart';

class OrderDetails extends StatefulWidget {
  final Orders order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

bool _expanded = false;

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    //final price = widget.order.items[index].price;
    final formattedDate =
        DateFormat('dd MMM, yyyy  hh:mm a').format(order.createdAt.toLocal());
    final formattedDate2 =
        DateFormat('dd MMM yyyy').format(order.createdAt.toLocal());
    final orderRef = order.orderId.replaceRange(14, null, '');

    final orderStatus = order.status == 'pending'
        ? Text(
            'Pending',
            style: GoogleFonts.roboto(
                color: Colors.red, fontWeight: EshopFontweight.semibold),
          )
        : order.status == 'delivered'
            ? Text(
                'Completed',
                style: TextStyle(
                    color: Colors.green, fontWeight: EshopFontweight.bold),
              )
            : Text(
                'On the way',
                style: TextStyle(
                    color: Colors.orange, fontWeight: EshopFontweight.semibold),
              );
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: Text(orderRef),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Appcolors.backgroundColor,
        child: Container(
          decoration: BoxDecoration(
              color: Appcolors.bottomNavActive,
              borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '\$${order.items[0].price.toString()}',
                      style: GoogleFonts.roboto(
                          color: Appcolors.backgroundColor,
                          fontSize: 22.sp,
                          fontWeight: EshopFontweight.bold),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Iconsax.verify,
                  color: Appcolors.backgroundColor,
                  size: 24.sp,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  'Received',
                  style: GoogleFonts.roboto(
                      color: Appcolors.backgroundColor,
                      fontSize: 17.sp,
                      fontWeight: EshopFontweight.medium),
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(),
              child: Column(
                spacing: 3.h,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: EshopFontweight.medium
                    ),
                  ),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Created:',
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        formattedDate,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontWeight: EshopFontweight.regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reference ID:',
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        orderRef,
                        style: GoogleFonts.roboto(
                          fontWeight: EshopFontweight.regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status:',
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                        ),
                      ),
                      orderStatus,
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Status',
                  style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    fontWeight: EshopFontweight.medium
                  ),
                ),
                OrderTrack(
                  date: formattedDate2,
                  title: 'Created',
                  location: 'eShop Parcels, Accra',
                  index: 1,
                  status: order.status,
                ),
                OrderTrack(
                  date: formattedDate2,
                  location: 'Accra',
                  title: 'On the way',
                  status: order.status,
                  hasDropdown: true,
                  isExpanded: _expanded,
                  onToggleExpand: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  index: 3,
                ),
                OrderTrack(
                    date: '',
                    title: 'Received',
                    status: widget.order.status,
                    location: '\$user address',
                    hasDropdown: false,
                    index: 2)
              ],
            ),
            Divider(),
            Expanded(
              child: Column(
                spacing: 3.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary (${widget.order.items.length})',
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: EshopFontweight.medium
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items',
                          style: GoogleFonts.roboto(
                              fontWeight: EshopFontweight.medium,
                              fontSize: EshopTypography.onboadingbody),
                        ),
                        Text('Qty(s)', style: GoogleFonts.roboto(
                              fontWeight: EshopFontweight.medium,
                              fontSize: EshopTypography.onboadingbody),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: order.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            order.items[index].productName,
                            style: GoogleFonts.roboto(fontSize: 13.sp,),
                          ),
                          trailing: Text(
                            order.items[index].quantity.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 13.sp,
                                fontWeight: EshopFontweight.semibold),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
