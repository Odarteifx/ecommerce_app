import 'package:cloud_firestore/cloud_firestore.dart';
import '../orders_model.dart';

class Order {
  final String orderId;
  final String email;
  final double total;
  final List<OrderItem> items;
  final String status;
  final DateTime createdAt;

  Order({
    required this.orderId,
    required this.email,
    required this.total,
    required this.items,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      email: json['email'],
      total: json['total'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      status: json['status'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'email': email,
      'total': total,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}