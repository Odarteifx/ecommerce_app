import 'dart:convert';

class WishlistItem {
  String productId;
  String image;
  String productName;
  double price;
  double? oldPrice;
  WishlistItem({
    required this.productId,
    required this.image,
    required this.productName,
    required this.price,
    this.oldPrice,
  });
  

  WishlistItem copyWith({
    String? productId,
    String? image,
    String? productName,
    double? price,
    double? oldPrice,
  }) {
    return WishlistItem(
      productId: productId ?? this.productId,
      image: image ?? this.image,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'image': image,
      'productName': productName,
      'price': price,
      'oldPrice': oldPrice,
    };
  }

  factory WishlistItem.fromMap(Map<String, dynamic> map, String id) {
    return WishlistItem(
      productId: id,
      image: map['image'] as String,
      productName: map['productName'] as String,
      price: map['price'] as double,
      oldPrice: map['oldPrice'] != null
          ? (map['oldPrice'] as num).toDouble()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistItem.fromJson(String source) => WishlistItem.fromMap(json.decode(source) as Map<String, dynamic>, '');

  @override
  String toString() {
    return 'WishlistItem(productId: $productId, image: $image, productName: $productName, price: $price, oldPrice: $oldPrice)';
  }

  @override
  bool operator ==(covariant WishlistItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.image == image &&
      other.productName == productName &&
      other.price == price &&
      other.oldPrice == oldPrice;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      image.hashCode ^
      productName.hashCode ^
      price.hashCode ^
      oldPrice.hashCode;
  }
}
