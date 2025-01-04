import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart_item.freezed.dart';
part 'cart_item.g.dart';


@freezed

abstract class CartItem with _$CartItem {
  const factory CartItem({
    required String productId,
    required String productName,
    required int quantity,
    double? oldPrice,
    required double price,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  
}

// class CartItem {
// //  final String id;
// final String productId;
//  //final String image;
//   final String productName;
//   final int quantity;
//   final double? oldPrice;
//   final double price;

//   CartItem({
//     //  required this.id,
//     required this.productId,
//    // required this.image,
//     required this.productName,
//     required this.quantity,
//     this.oldPrice,
//     required this.price,
//   });

//   CartItem copyWith({
//     // String? id,
//     String? productId,
//     //String? image,
//     String? productName,
//     int? quantity,
//     double? oldPrice,
//     double? price,
//   }) {
//     return CartItem(
//       //  id: id ?? this.id,
//        productId: productId ?? this.productId,
//      // image: image ?? this.image,
//       productName: productName ?? this.productName,
//       quantity: quantity ?? this.quantity,
//       oldPrice: oldPrice ?? this.oldPrice,
//       price: price ?? this.price,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       //  'id': id,
//        'productId': productId,
//       // 'image': image,
//       'productName': productName,
//       'quantity': quantity,
//       'oldPrice': oldPrice,
//       'price': price,
//     };
//   }

//   factory CartItem.fromMap(Map<String, dynamic> map) {
//     return CartItem(
//       // id: map['id'] as String,
//       productId: map['productId'] as String,
//       // image: map['image'] as String,
//       productName: map['productName'] as String,
//       quantity: map['quantity'] != null ? map['quantity'] as int : 1,
//       oldPrice: map['oldPrice'] != null ? (map['oldPrice'] as num).toDouble() : null,
//       price: map['price'] as double,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'CartItem( productId: $productId, productName: $productName, quantity: $quantity, oldPrice: $oldPrice, price: $price)';
//   }

//   @override
//   bool operator ==(covariant CartItem other) {
//     if (identical(this, other)) return true;

//     return 
//     // other.id == id &&
//         other.productId == productId &&
//         // other.image == image &&
//         other.productName == productName &&
//         other.quantity == quantity &&
//         other.oldPrice == oldPrice &&
//         other.price == price;
//   }

//   @override
//   int get hashCode {
//     return
//     //  id.hashCode ^
//         productId.hashCode ^
//         // image.hashCode ^
//         productName.hashCode ^
//         quantity.hashCode ^
//         oldPrice.hashCode ^
//         price.hashCode;
//   }
// }