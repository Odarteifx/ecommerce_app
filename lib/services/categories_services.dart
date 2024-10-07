import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/categories_model.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/firebase_constants.dart';

final categoriesServiceProvider = Provider((ref) => CategoriesServices(firestore: ref.watch(firebaseFirestoreProvider)));
class CategoriesServices {
  final FirebaseFirestore _firestore;

  CategoriesServices({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _categories =>
      _firestore.collection(FirebaseConstants.categories);
  Stream<List<Categories>>getCategories() {
    return _categories.snapshots().map((event){
      List<Categories>categorieslist = [];
      for (var doc in event.docs) {
        categorieslist.add(Categories.fromMap(doc.data() as Map<String,dynamic>));
      }
      return categorieslist;
    });
  }
}
