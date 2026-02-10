import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_models/orders_model.dart';

final ordersServicesProvider = Provider<OrdersServices>((ref) {
  return OrdersServices();
});

class OrdersServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Orders>> getOrders(String userId) {
    debugPrint('OrdersServices: Starting to fetch orders for userId: $userId');
    debugPrint('OrdersServices: Path: users/$userId/orders');
    
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .snapshots()
        .handleError((error) {
          debugPrint('OrdersServices: Stream error: $error');
        })
        .map((snapshot) {
          debugPrint('OrdersServices: Received snapshot with ${snapshot.docs.length} documents');
          debugPrint('OrdersServices: Snapshot metadata - fromCache: ${snapshot.metadata.isFromCache}, hasPendingWrites: ${snapshot.metadata.hasPendingWrites}');
          
          final orders = <Orders>[];
          for (final doc in snapshot.docs) {
            try {
              debugPrint('OrdersServices: Parsing document ${doc.id}');
              debugPrint('OrdersServices: Document data: ${doc.data()}');
              final order = Orders.fromMap(doc.data());
              orders.add(order);
              debugPrint('OrdersServices: Successfully parsed order: ${order.orderId}');
            } catch (e, stack) {
              debugPrint('OrdersServices: Error parsing document ${doc.id}: $e');
              debugPrint('OrdersServices: Stack trace: $stack');
            }
          }
          
          // Sort by date in memory (newest first) to avoid requiring Firestore index
          orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          debugPrint('OrdersServices: Returning ${orders.length} orders');
          return orders;
        });
  }

  Future<void> addOrder(Orders order) async {
    final user = auth.currentUser;
    if (user == null) {
      debugPrint('OrdersServices: Cannot add order - no user logged in');
      return;
    }
    
    debugPrint('OrdersServices: Adding order ${order.orderId} for user ${user.uid}');
    debugPrint('OrdersServices: Order data: ${order.toMap()}');
    
    final userRef = _firestore.collection('users').doc(user.uid);
    final orderRef = userRef.collection('orders').doc(order.orderId);

    try {
      await orderRef.set(order.toMap());
      debugPrint('OrdersServices: Order ${order.orderId} added successfully');
    } catch (e, stack) {
      debugPrint('OrdersServices: Error adding order: $e');
      debugPrint('OrdersServices: Stack trace: $stack');
      rethrow;
    }
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

  /// Debug method to check all orders for current user
  Future<void> debugCheckOrders() async {
    final user = auth.currentUser;
    if (user == null) {
      debugPrint('DEBUG: No user logged in');
      return;
    }
    
    debugPrint('DEBUG: Checking orders for user: ${user.uid}');
    
    try {
      // Check if user document exists
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      debugPrint('DEBUG: User document exists: ${userDoc.exists}');
      
      // Get all orders
      final ordersSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .get();
      
      debugPrint('DEBUG: Found ${ordersSnapshot.docs.length} orders');
      
      for (final doc in ordersSnapshot.docs) {
        debugPrint('DEBUG: Order ID: ${doc.id}');
        debugPrint('DEBUG: Order data: ${doc.data()}');
      }
    } catch (e) {
      debugPrint('DEBUG: Error checking orders: $e');
    }
  }
}
