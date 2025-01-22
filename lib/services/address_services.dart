import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressServicesProvider = Provider<AddressServices>((ref){
  return AddressServices();
});

class AddressServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream <List<ShippingAddress>> getShippingAddress(String userId, {required String fullName}) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('shipping_address')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ShippingAddress.fromMap(doc.data())).toList());
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
}