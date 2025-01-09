import 'package:ecommerce_app/models/wishlist_model.dart';
import 'package:ecommerce_app/services/wishlist_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistProvider = StreamProvider<List<WishlistItem>>((ref){
  final wishlistServices = ref.watch(wishlistServiceProvider);
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return Stream.value([]);
  }
  final userId = user.uid;
  return wishlistServices.getWishlistItems(userId);
});

class WishlistController extends StateNotifier<List<WishlistItem>> {
  WishlistController() :super([]);

  void addToWishlist(WishlistItem item) async{
    final wishlistServices = WishlistServices();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      state = [...state, item];
      await wishlistServices.addToWishlist(item);
    }
  }

  void removeFromWishlist(String itemId) async{
    final wishlistServices = WishlistServices();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      state = state.where((item) => item.id != itemId).toList();
      await wishlistServices.removeFromWishlist(itemId);
    }
  }
}

final wishlistControllerProvider = StateNotifierProvider<WishlistController, List<WishlistItem>>((ref){
  return WishlistController();
});