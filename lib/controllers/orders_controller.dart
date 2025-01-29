import 'package:ecommerce_app/models/order_models/orders_model.dart';
import 'package:ecommerce_app/services/orders_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersControllerProvider = StateNotifierProvider<OrdersController, List<Orders>>((ref) {
  final ordersServices = ref.watch(ordersServicesProvider);
  return OrdersController(ordersServices);
});

class OrdersController extends StateNotifier<List<Orders>> {
  final OrdersServices _ordersServices;

  OrdersController(this._ordersServices) : super([]) {
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      _ordersServices.getOrders(userId).listen((order) {
        state = order;
      });
    }
  }

  Future<void> addOrder(Orders order) async {
    await _ordersServices.addOrder(order);
  }

  Future<void> updateOrder(Orders order) async {
    await _ordersServices.updateOrder(order);
  }

  Future<void> deleteOrder(String orderId) async {
    await _ordersServices.deleteOrder(orderId);
  }
    
}