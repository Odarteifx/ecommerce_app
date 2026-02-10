import 'package:ecommerce_app/constants/colors.dart';
import 'package:ecommerce_app/constants/eshop_typography.dart';
import 'package:ecommerce_app/controllers/orders_controller.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:ecommerce_app/services/orders_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../widgets/eshop_widgets.dart';
import 'order_details.dart';

class MyOrdersScreen extends ConsumerWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersStreamProvider);
    
    // Debug logging
    ordersAsync.when(
      data: (orders) => debugPrint('MyOrdersScreen: Loaded ${orders.length} orders'),
      loading: () => debugPrint('MyOrdersScreen: Loading orders...'),
      error: (e, s) => debugPrint('MyOrdersScreen: Error loading orders: $e'),
    );
    
    return Scaffold(
      backgroundColor: Appcolors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolors.backgroundColor,
        title: const Text('My Orders'),
        actions: [
          IconButton(
            onPressed: () async {
              // Debug: check orders directly
              final ordersServices = ref.read(ordersServicesProvider);
              await ordersServices.debugCheckOrders();
              ref.invalidate(ordersStreamProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      // Debug: Add test order button
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please login first')),
                  );
                  return;
                }

                // Create a test order
                final testOrder = Orders(
                  orderId: 'test-order-${DateTime.now().millisecondsSinceEpoch}',
                  email: user.email ?? 'test@test.com',
                  total: 99.99,
                  items: [
                    OrderItem(
                      productId: 'test-product-1',
                      productName: 'Test Product',
                      quantity: 1,
                      price: 99.99,
                    ),
                  ],
                  transactionRef: 'test-ref-${DateTime.now().millisecondsSinceEpoch}',
                  status: 'pending',
                  createdAt: DateTime.now(),
                );

                debugPrint('Creating test order: ${testOrder.orderId}');
                
                try {
                  await ref.read(ordersControllerProvider.notifier).addOrder(testOrder);
                  debugPrint('Test order created successfully!');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Test order created!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  debugPrint('Error creating test order: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No orders placed',
                style: GoogleFonts.roboto(
                  color: Appcolors.iconColor,
                  fontSize: EshopTypography.onboadingbody,
                ),
              ),
            );
          }
          return ListView.builder(
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
                  child: const Icon(
                    Iconsax.box,
                    color: Appcolors.backgroundColor,
                  ),
                ),
                title: Text(
                  'Order ID: #${order.orderId.length > 14 ? order.orderId.replaceRange(14, null, '...') : order.orderId}',
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
                    ? const OrderStatus(
                        backgroundColor: Color(0xFFFFEBEE),
                        statusColor: Colors.redAccent,
                        status: 'Pending')
                    : order.status == 'delivered'
                        ? const OrderStatus(
                            backgroundColor: Color(0xFFE6F4EA),
                            statusColor: Colors.green,
                            status: 'Completed')
                        : const OrderStatus(
                            backgroundColor: Color(0xFFFFF4E5),
                            statusColor: Colors.orange,
                            status: 'Processing',
                          ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error loading orders',
                style: GoogleFonts.roboto(
                  color: Appcolors.iconColor,
                  fontSize: EshopTypography.onboadingbody,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(ordersStreamProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


