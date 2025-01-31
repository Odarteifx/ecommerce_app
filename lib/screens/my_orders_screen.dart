import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'order_details.dart';

class MyOrdersScreen extends ConsumerWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersControllerProvider);
    return Scaffold(
        backgroundColor: Appcolors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Appcolors.backgroundColor,
          title: Text('My Orders'),
        ),
        body: orders.isNotEmpty
            ? ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final formattedDate = DateFormat('dd MMM, yyyy  hh:mm a')
                      .format(order.createdAt.toLocal());
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OrderDetails(order: order);
                      }));
                    },
                    leading: CircleAvatar(
                      backgroundColor: order.status == 'pending'
                          ? Colors.grey
                          : order.status == 'delivered'
                              ? Colors.green
                              : Colors.orange,
                      child: Icon(
                        Iconsax.box,
                        color: Appcolors.backgroundColor,
                      ),
                    ),
                    title: Text(
                      'Order ID: #${order.orderId.replaceRange(14, null, '')}',
                      style: TextStyle(
                          fontSize: EshopTypography.termsfont,
                          fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      'Created: $formattedDate',
                      style: TextStyle(fontSize: EshopTypography.termsfont),
                    ),
                    trailing: order.status == 'pending'
                        ? Text(
                            'Pending',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: EshopTypography.termsfont,
                                fontWeight: EshopFontweight.semibold),
                          )
                        : order.status == 'delivered'
                            ? Text(
                                'Completed',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: EshopTypography.termsfont,
                                    fontWeight: EshopFontweight.semibold),
                              )
                            : Text(
                                'Processing',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: EshopTypography.termsfont,
                                    fontWeight: EshopFontweight.semibold),
                              ),
                  );
                },
              )
            : Center(
                child: Text(
                  'No orders placed',
                  style: GoogleFonts.roboto(
                      color: Appcolors.iconColor,
                      fontSize: EshopTypography.onboadingbody),
                ),
              ));
  }
}
