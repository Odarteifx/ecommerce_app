import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/services/cart_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StreamProvider<List<CartItem>>((ref) {
  final firebaseCartServices = ref.watch(cartServiceProvider);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value([]); // Return an empty list if the user is not logged in
  }
  final userId = user.uid;
  return firebaseCartServices.getCartItems(userId);
});

class CartController extends StateNotifier<List<CartItem>> {
  CartController() : super([]);

  void addToCart(CartItem item) async {
    final firebaseCartServices = CartServices();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final existingItemIndex = state.indexWhere((cartItem) => cartItem.productName == item.productName);

      if (existingItemIndex >= 0) {
        final existingItem = state[existingItemIndex];
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);

        state = [
          ...state.sublist(0, existingItemIndex),
          updatedItem,
          ...state.sublist(existingItemIndex + 1)
        ];
        await firebaseCartServices.updateCartItem(user.uid, updatedItem);
      } else {
        
      }
    } else {
      
    }
    await firebaseCartServices.addToCart(item);
    state = [...state, item];
  }

  void clearCart() {
    final firebaseCartServices = CartServices();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      state.forEach((cartItem) async {
        await firebaseCartServices.removeFromCart(cartItem.productName);
      });
    }
    state = [];
  }
}

final cartControllerProvider = StateNotifierProvider<CartController, List<CartItem>>((ref) {
  return CartController();
});