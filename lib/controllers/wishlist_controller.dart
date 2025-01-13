import 'package:ecommerce_app/services/wishlist_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wishlist_model.dart';

final wishlistProvider = StreamProvider<List<WishlistItem>>((ref) {
  final wishlistServices = ref.watch(wishlistServiceProvider);
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value([]); 
  }
  final userId = user.uid;
  return wishlistServices.getWishlistItems(userId);
});

class WishlistController extends StateNotifier<List<WishlistItem>> {
  final WishlistServices wishlistServices;

  WishlistController(this.wishlistServices) : super([]);

  void addToWishlist(WishlistItem item) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      state = [...state, item];
      await wishlistServices.addToWishlist(item);
    }
  }

  void removeFromWishlist(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      state = state.where((item) => item.productId != productId).toList();
      await wishlistServices.removeFromWishlist(productId);
    }
  }
}

final wishlistControllerProvider = StateNotifierProvider<WishlistController, List<WishlistItem>>((ref) {
  final wishlistServices = ref.watch(wishlistServiceProvider);
  return WishlistController(wishlistServices);
});
