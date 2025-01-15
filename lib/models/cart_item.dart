import 'dart:convert';

class CartItem {
  final String productId;
  final String? image;
  final String productName;
  final int quantity;
  final double? oldPrice;
  final double price;

  CartItem({
    required this.productId,
    required this.image,
    required this.productName,
    required this.quantity,
    this.oldPrice,
    required this.price,
  });

  CartItem copyWith({
    String? productId,
    String? image,
    String? productName,
    int? quantity,
    double? oldPrice,
    double? price,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      image: image ?? this.image,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'image': image,
      'productName': productName,
      'quantity': quantity,
      'oldPrice': oldPrice,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] ?? '',
      image: map['image'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] != null ? map['quantity'] as int : 1,
      oldPrice: map['oldPrice'] != null ? (map['oldPrice'] as num).toDouble() : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(productId: $productId, image: $image, productName: $productName, quantity: $quantity, oldPrice: $oldPrice, price: $price)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.image == image &&
        other.productName == productName &&
        other.quantity == quantity &&
        other.oldPrice == oldPrice &&
        other.price == price;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        image.hashCode ^
        productName.hashCode ^
        quantity.hashCode ^
        oldPrice.hashCode ^
        price.hashCode;
  }
}