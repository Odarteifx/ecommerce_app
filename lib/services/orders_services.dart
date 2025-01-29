import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_models/orders_model.dart';

final ordersServicesProvider = Provider<OrdersServices>((ref) {
  return OrdersServices();
});

class OrdersServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Orders>> getOrders(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Orders.fromMap(doc.data())).toList());
  }

  Future<void> addOrder(Orders order) async {
    final user = auth.currentUser;
    final userRef = _firestore.collection('users').doc(user!.uid);
    final orderRef = userRef.collection('orders').doc(order.orderId);

    await orderRef.set(order.toMap());
  }

  Future<void> updateOrder(Orders order) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(order.orderId)
          .update(order.toMap());
    }
  }

  Future<void> deleteOrder(String orderId) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(orderId)
          .delete();
    }
  }

  Future<Orders?> getOrderById(String orderId) async {
    final user = auth.currentUser;
    if (user != null) {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(orderId)
          .get();
      if (doc.exists) {
        return Orders.fromMap(doc.data()!);
      }
    }
    return null;
  }
}
