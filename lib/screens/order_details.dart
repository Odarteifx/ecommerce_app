import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final formattedDate =
        DateFormat('dd MMM, yyyy  hh:mm a').format(widget.order.createdAt.toLocal());
    final formattedDate2 =
        DateFormat('dd MMM yyyy').format(widget.order.createdAt.toLocal());
    final orderRef = widget.order.orderId.replaceRange(14, null, '');
    
    final orderStatus = widget.order.status == 'pending'
        ? Text(
            'Pending',
            style: GoogleFonts.roboto(
                color: Colors.red, fontWeight: EshopFontweight.semibold),
          )
        : widget.order.status == 'delivered'
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
                  ),
                ),
                OrderTrack(
                  date: formattedDate2,
                  title: 'Created',
                  location: 'eShop Parcels, Accra',
                  index: 1,
                  status: widget.order.status,
                ),
                OrderTrack(
                  date: formattedDate2,
                  location: 'ACCRA',
                  title: 'On the way',
                  status: widget.order.status,
                  hasDropdown:true,
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
          ],
        ),
      ),
    );
  }
}
