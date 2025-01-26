import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shipping_model.dart';

final addressServicesProvider = Provider<AddressServices>((ref) {
  return AddressServices();
});

class AddressServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<ShippingAddress>> getShippingAddress(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('shipping_address')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ShippingAddress.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addShippingAddress(ShippingAddress address) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('shipping_address')
          .add(address.toMap());
    }
  }

  Future<void> updateShippingAddress(ShippingAddress address) async {
    final user = auth.currentUser;
    if (user != null && address.id != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('shipping_address')
          .doc(address.id)
          .update(address.toMap());
    }
  }

  Future<void> deleteShippingAddress(String addressId) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('shipping_address')
          .doc(addressId)
          .delete();
    }
  }

  Future<ShippingAddress?> getShippingAddressById(String addressId) async {
    final user = auth.currentUser;
    if (user != null) {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('shipping_address')
          .doc(addressId)
          .get();
      if (doc.exists) {
        return ShippingAddress.fromMap(doc.data()!, doc.id);
      }
    }
    return null;
  }
}
