import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartServiceProvider = Provider<CartServices>((ref) {
  return CartServices();
});

class CartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .add(item.toMap());
    }
  }

   Future<void> updateCartItem(String userId, CartItem item) async {
    final cartItemDoc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .where('productId', isEqualTo: item.productId)
        .limit(1)
        .get();

    if (cartItemDoc.docs.isNotEmpty) {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartItemDoc.docs.first.id)
          .update(item.toMap());
    }
  }

  Future<void> removeFromCart(String itemId) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(itemId)
          .delete();
    }
  }
}