import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StreamProvider<List<CartItem>>((ref){
  final firebaseCartServices = ref.watch(cartServiceProvider);
  final userId = FirebaseAuth.instance.currentUser!.uid;
  return firebaseCartServices.getCartItems();
});