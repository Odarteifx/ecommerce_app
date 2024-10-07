import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/data_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Firebase Provider
final firebaseFirestoreProvider = Provider((ref)=> FirebaseFirestore.instance);
final firebaseAuthProvider = Provider((ref)=> FirebaseAuth.instance);
final firebaseStorageProvdier = Provider((ref)=> FirebaseStorage.instance);


final ValueNotifier<int> bannerIndexNotifier = ValueNotifier<int>(0);
final termsProvdier = StateProvider<bool>((ref) {
  return false;
});

class EshopProvider extends ChangeNotifier {
  void addtoWishlist(ProductModel product){

  }
}
