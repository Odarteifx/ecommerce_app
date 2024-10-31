import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User? user = auth.currentUser;
  late final String? userId = user?.uid;

  Future<void> addToCart(CartItem item) async {
    await _firestore.collection('users').doc(userId).collection('cart').add(item.toMap());
  }

  Future<void> removeFromCart(String itemId) async{
    await _firestore.collection('users').doc(userId).collection('cart').doc(itemId).delete();
  }
}