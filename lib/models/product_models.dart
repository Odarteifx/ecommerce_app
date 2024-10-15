// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String productId;
  String name;
  String image;
  double price;
  double? oldPrice;
  bool? isAvailable;
  String description;
  String categoryname;
  ProductModel({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    this.isAvailable,
    required this.description,
    required this.categoryname,
  });

  ProductModel copyWith({
    String? productId,
    String? name,
    String? image,
    double? price,
    double? oldPrice,
    bool? isAvailable,
    String? description,
    String? categoryname,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      categoryname: categoryname ?? this.categoryname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ProductId': productId,
      'name': name,
      'image': image,
      'price': price,
      'oldPrice': oldPrice,
      'isAvailable': isAvailable,
      'description': description,
      'categoryname': categoryname,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['ProductId'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] (map['price'] as num).toDouble(),
      oldPrice: map['oldPrice'] != null ? map['oldPrice'] (map['oldPrice'] as num).toDouble() : null,  // Null check,
      isAvailable: map['isAvailable'] != null ? map['isAvailable'] as bool : null,
      description: map['description'] as String,
      categoryname: map['categoryname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(ProductId: $productId, name: $name, image: $image, price: $price, oldPrice: $oldPrice, isAvailable: $isAvailable, description: $description, categoryname: $categoryname)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.name == name &&
      other.image == image &&
      other.price == price &&
      other.oldPrice == oldPrice &&
      other.isAvailable == isAvailable &&
      other.description == description &&
      other.categoryname == categoryname;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      oldPrice.hashCode ^
      isAvailable.hashCode ^
      description.hashCode ^
      categoryname.hashCode;
  }
}
