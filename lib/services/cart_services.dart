import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartServiceProvider = Provider(
  (ref){
    return CartServices;
  }
);

class CartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User? user = auth.currentUser;
  late final String? userId = user?.uid;

  Stream<List<CartItem>> getCartItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList());
  }

  Future<void> addToCart(CartItem item) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .add(item.toMap());
  }

  Future<void> removeFromCart(String itemId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(itemId)
        .delete();
  }
}
