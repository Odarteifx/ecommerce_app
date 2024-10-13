// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String ProductId;
  String name;
  String image;
  String price;
  String oldPrice;
  bool? isAvailable;
  String description;
  String categoryname;
  ProductModel({
    required this.ProductId,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    this.isAvailable,
    required this.description,
    required this.categoryname,
  });

  ProductModel copyWith({
    String? ProductId,
    String? name,
    String? image,
    String? price,
    String? oldPrice,
    bool? isAvailable,
    String? description,
    String? categoryname,
  }) {
    return ProductModel(
      ProductId: ProductId ?? this.ProductId,
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
      'ProductId': ProductId,
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
      ProductId: map['ProductId'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as String,
      oldPrice: map['oldPrice'] as String,
      isAvailable: map['isAvailable'] != null ? map['isAvailable'] as bool : null,
      description: map['description'] as String,
      categoryname: map['categoryname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(ProductId: $ProductId, name: $name, image: $image, price: $price, oldPrice: $oldPrice, isAvailable: $isAvailable, description: $description, categoryname: $categoryname)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.ProductId == ProductId &&
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
    return ProductId.hashCode ^
      name.hashCode ^
      image.hashCode ^
      price.hashCode ^
      oldPrice.hashCode ^
      isAvailable.hashCode ^
      description.hashCode ^
      categoryname.hashCode;
  }
}
