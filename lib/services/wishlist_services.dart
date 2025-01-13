import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistServiceProvider = Provider<WishlistServices>((ref) {
  return WishlistServices();
});

class WishlistServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<WishlistItem>> getWishlistItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WishlistItem.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addToWishlist(WishlistItem item) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(item.productId) 
          .set(item.toMap());
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('wishlist')
          .doc(productId)
          .delete();
    }
  }
}
