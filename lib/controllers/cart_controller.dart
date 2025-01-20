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
      final existingItemIndex = state.indexWhere((cartItem) => cartItem.productId == item.productId);

      if (existingItemIndex >= 0) {
        final existingItem = state[existingItemIndex];
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + item.quantity);

        state = [
          ...state.sublist(0, existingItemIndex),
          updatedItem,
          ...state.sublist(existingItemIndex + 1)
        ];
        await firebaseCartServices.updateCartItem(user.uid, updatedItem);
      } else {
        state = [...state, item];
        await firebaseCartServices.addToCart(item);
      }
    }
  }

  void removeFromCart(String productId) async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final updatedState = List.from(state);
      final firebaseCartServices = CartServices();
      state = state.where((item) => item.productId != item.productId).toList();
      await firebaseCartServices.removeFromCart(user.uid, productId);

      
      state = updatedState.cast<CartItem>();
    }
  }

  void clearCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final firebaseCartServices = CartServices();
      await firebaseCartServices.clearCart(user.uid);
      state = [];
    }
  }

  void increaseQuantity(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final existingItemIndex = state.indexWhere((item) => item.productId == productId);
      if (existingItemIndex >= 0) {
        final updatedState = List.from(state);
        final existingItem = state[existingItemIndex];
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);

        updatedState[existingItemIndex] = updatedItem;

        state = updatedState.cast<CartItem>();
        await CartServices().updateCartItem(user.uid, updatedItem);
      }
    }
  }

  void decreaseQuantity(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final existingItemIndex = state.indexWhere((item) => item.productId == productId);
      if (existingItemIndex >= 0) {
        final existingItem = state[existingItemIndex];
        if (existingItem.quantity > 1) {
           final updatedState = List.from(state);
          final updatedItem = existingItem.copyWith(quantity: existingItem.quantity - 1);

           updatedState[existingItemIndex] = updatedItem;
           state = updatedState.cast<CartItem>(); 
          await CartServices().updateCartItem(user.uid, updatedItem);
        } else {
          removeFromCart(productId);
        }
      }
    }
  }
}



final cartControllerProvider = StateNotifierProvider<CartController, List<CartItem>>((ref) {
  return CartController();
});