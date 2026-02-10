import 'dart:async';
import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:ecommerce_app/services/orders_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that watches Firebase auth state changes
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Stream provider for real-time orders updates - depends on current user
final ordersStreamProvider = StreamProvider<List<Orders>>((ref) {
  // Watch auth state to refresh when user changes
  final authState = ref.watch(authStateProvider);
  final ordersServices = ref.watch(ordersServicesProvider);
  
  return authState.when(
    data: (user) {
      if (user == null) {
        debugPrint('No user logged in - returning empty orders');
        return Stream.value(<Orders>[]);
      }
      debugPrint('Fetching orders for user: ${user.uid}');
      return ordersServices.getOrders(user.uid);
    },
    loading: () => Stream.value(<Orders>[]),
    error: (_, __) => Stream.value(<Orders>[]),
  );
});

final ordersControllerProvider = StateNotifierProvider<OrdersController, List<Orders>>((ref) {
  final ordersServices = ref.watch(ordersServicesProvider);
  // Watch auth state to refresh controller when user changes
  ref.watch(authStateProvider);
  return OrdersController(ordersServices, ref);
});

class OrdersController extends StateNotifier<List<Orders>> {
  final OrdersServices _ordersServices;
  // ignore: unused_field
  final Ref _ref;
  StreamSubscription<List<Orders>>? _ordersSubscription;

  OrdersController(this._ordersServices, this._ref) : super([]) {
    _fetchOrders();
  }

  void _fetchOrders() {
    // Get current user from Firebase Auth
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      debugPrint('OrdersController: Fetching orders for user: $userId');
      // Cancel any existing subscription
      _ordersSubscription?.cancel();
      // Create new subscription
      _ordersSubscription = _ordersServices.getOrders(userId).listen(
        (orders) {
          state = orders;
          debugPrint('OrdersController: Updated with ${orders.length} orders for user: $userId');
        },
        onError: (error) {
          debugPrint('OrdersController: Error fetching orders: $error');
        },
      );
    } else {
      debugPrint('OrdersController: No user logged in');
      state = [];
    }
  }

  Future<void> addOrder(Orders order) async {
    await _ordersServices.addOrder(order);
    // The stream will automatically update the state
  }

  Future<void> updateOrder(Orders order) async {
    await _ordersServices.updateOrder(order);
  }

  Future<void> deleteOrder(String orderId) async {
    await _ordersServices.deleteOrder(orderId);
  }

  /// Manually refresh orders
  void refreshOrders() {
    _fetchOrders();
  }

  @override
  void dispose() {
    _ordersSubscription?.cancel();
    super.dispose();
  }
}