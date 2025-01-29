import 'dart:convert';

class OrderItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  OrderItem copyWith({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(productId: $productId, productName: $productName, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}
