class CartItem {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double oldPrice;
  final double price;

  CartItem(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.quantity,
      required this.oldPrice,
      required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'oldPrice': oldPrice,
      'price': price
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        id: map['id'],
        productId: map['productId'],
        productName: map['productName'],
        quantity: map['quantity'],
        oldPrice: map['oldPrice'],
        price: map['price']);
  }
}
