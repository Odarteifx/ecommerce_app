import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartItem {
  final String id;
  final String productId;
  final String productName;
  final int? quantity;
  final double? oldPrice;
  final double price;
  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.oldPrice,
    required this.price,
  });

  

  CartItem copyWith({
    String? id,
    String? productId,
    String? productName,
    int? quantity,
    double? oldPrice,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'oldPrice': oldPrice,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      quantity: map['quantity'] as int,
      oldPrice: map['oldPrice'] != null ? (map['oldPrice'] as num).toDouble() : null,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, productId: $productId, productName: $productName, quantity: $quantity, oldPrice: $oldPrice, price: $price)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productId == productId &&
      other.productName == productName &&
      other.quantity == quantity &&
      other.oldPrice == oldPrice &&
      other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productId.hashCode ^
      productName.hashCode ^
      quantity.hashCode ^
      oldPrice.hashCode ^
      price.hashCode;
  }
}
