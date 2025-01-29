import 'dart:convert';
import 'package:ecommerce_app/models/order_models/order_item.dart';
import 'package:flutter/foundation.dart';

class Orders {
  final String orderId;
  final String email;
  final double total;
  final List<OrderItem> items;
  final String status;
  final DateTime createdAt;
  Orders({
    required this.orderId,
    required this.email,
    required this.total,
    required this.items,
    required this.status,
    required this.createdAt,
  });


  Orders copyWith({
    String? orderId,
    String? email,
    double? total,
    List<OrderItem>? items,
    String? status,
    DateTime? createdAt,
  }) {
    return Orders(
      orderId: orderId ?? this.orderId,
      email: email ?? this.email,
      total: total ?? this.total,
      items: items ?? this.items,
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
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderId: map['orderId'] as String,
      email: map['email'] as String,
      total: map['total'] as double,
      items: List<OrderItem>.from((map['items'] as List<dynamic>).map<OrderItem>((x) => OrderItem.fromMap(x as Map<String,dynamic>),),),
      status: map['status'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) => Orders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Orders(orderId: $orderId, email: $email, total: $total, items: $items, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Orders other) {
    if (identical(this, other)) return true;
  
    return 
      other.orderId == orderId &&
      other.email == email &&
      other.total == total &&
      listEquals(other.items, items) &&
      other.status == status &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
      email.hashCode ^
      total.hashCode ^
      items.hashCode ^
      status.hashCode ^
      createdAt.hashCode;
  }
}
