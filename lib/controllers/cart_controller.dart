import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StreamProvider<List<CartItem>>((ref){
  final firebaseCartServices = ref.watch(cartServiceProvider);
  final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
    return Stream.value([]); // Return an empty list if the user is not logged in
  }
  final userId = user.uid;
  return firebaseCartServices.getCartItems(userId);
});