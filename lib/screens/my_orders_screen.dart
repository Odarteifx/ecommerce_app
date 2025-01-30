import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                  final formattedDate = DateFormat('dd/MM/yyyy')
                      .format(order.createdAt.toLocal());
                  return ListTile(
                    onTap: () {},
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
                            style: TextStyle(color: Colors.red),
                          )
                        : order.status == 'delivered'
                            ? Text(
                                'Delivered',
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(
                                'Processing',
                                style: TextStyle(color: Colors.grey),
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
