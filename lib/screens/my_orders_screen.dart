import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return ListTile(
              title: Text(
                'Order Id: #${order.orderId}',
                style: TextStyle(fontSize: EshopTypography.termsfont),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                'Created: ${order.createdAt.year}/${order.createdAt.day}/${order.createdAt.month}',
                style: TextStyle(fontSize: EshopTypography.termsfont),
              ),
              trailing: order.status == 'pending'
                  ? Text(
                      'Pending',
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      'Delivered',
                      style: TextStyle(color: Colors.green),
                    ),
            );
          },
        ));
  }
}
