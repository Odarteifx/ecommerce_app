import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ecommerce_app/models/order_models/order_item.dart';

class Orders {
  final String orderId;
  final String email;
  final double total;
  final List<OrderItem> items;
  final String? transactionRef;
  final String status;
  final DateTime createdAt;
  Orders({
    required this.orderId,
    required this.email,
    required this.total,
    required this.items,
    required this.transactionRef,
    required this.status,
    required this.createdAt,
  });

  Orders copyWith({
    String? orderId,
    String? email,
    double? total,
    List<OrderItem>? items,
    String? transactionRef,
    String? status,
    DateTime? createdAt,
  }) {
    return Orders(
      orderId: orderId ?? this.orderId,
      email: email ?? this.email,
      total: total ?? this.total,
      items: items ?? this.items,
      transactionRef: transactionRef ?? this.transactionRef,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'email': email,
      'total': total,
      'items': items.map((x) => x.toMap()).toList(),
      'transactionRef': transactionRef,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    // Handle different date formats from Firestore
    DateTime parsedDate;
    final createdAtValue = map['createdAt'];
    if (createdAtValue is Timestamp) {
      // Firestore Timestamp object
      parsedDate = createdAtValue.toDate();
    } else if (createdAtValue is int) {
      // Milliseconds since epoch
      parsedDate = DateTime.fromMillisecondsSinceEpoch(createdAtValue);
    } else if (createdAtValue is String) {
      // ISO 8601 string format
      parsedDate = DateTime.tryParse(createdAtValue) ?? DateTime.now();
    } else {
      // Default to current time if no valid date
      parsedDate = DateTime.now();
    }

    // Handle total which might be int or double
    final totalValue = map['total'];
    final double parsedTotal = totalValue is int 
        ? totalValue.toDouble() 
        : (totalValue as double?) ?? 0.0;

    return Orders(
      orderId: map['orderId'] as String? ?? '',
      email: map['email'] as String? ?? '',
      total: parsedTotal,
      items: List<OrderItem>.from(
        (map['items'] as List<dynamic>? ?? []).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      transactionRef: map['transactionRef'] as String?,
      status: map['status'] as String? ?? 'pending',
      createdAt: parsedDate,
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) =>
      Orders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Orders(orderId: $orderId, email: $email, total: $total, items: $items, transactionRef: $transactionRef, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Orders other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.email == email &&
        other.total == total &&
        listEquals(other.items, items) &&
        other.transactionRef == transactionRef &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        email.hashCode ^
        total.hashCode ^
        items.hashCode ^
        transactionRef.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }
}
