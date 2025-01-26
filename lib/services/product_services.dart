import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants/firebase_constants.dart';
import 'package:ecommerce_app/models/product_models.dart';
import 'package:ecommerce_app/providers/eshop_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final prodcutServiceProvider = Provider((ref) {
  return ProductServices(firestore: ref.watch(firebaseFirestoreProvider));
});

class ProductServices {
  final FirebaseFirestore _firestore;
  

  ProductServices({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _products =>
      _firestore.collection(FirebaseConstants.products);

  Stream<List<ProductModel>> getProducts() {
    return _products.snapshots().map((event) {
      List<ProductModel> productList = [];
      for (var doc in event.docs) {
        productList
            .add(ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return productList;
    });
  }

  Stream<List<ProductModel>> getProductsbyCategory(String categoryname) {
    return _products
        .where('categoryname', isEqualTo: categoryname)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return products;
    });
    
  }

  Stream<List<ProductModel>> getRelatedProducts(String categoryname) {
    return _products
        .where('categoryname', isEqualTo: categoryname)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return products;
    });
  }

   Stream<ProductModel> getProductId(String productId) {
    return _products.doc(productId).snapshots().map((event) {
      return ProductModel.fromMap(event.data() as Map<String, dynamic>, event.id);
    });
  }


  Stream<List<ProductModel>> searchProducts(String search, {int limit = 10}) {
    return _products
        .where('name', isGreaterThanOrEqualTo: search)
        .where('name', isLessThanOrEqualTo: '$search\uf8ff')
        .limit(limit)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return products;
    });
  }

  Stream<List<ProductModel>> searchProductsByFields(String search, {int limit = 10}) {
    return _products
        .where('keywords', arrayContains: search)
        .limit(limit)
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      for (var doc in event.docs) {
        products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id));
      }
      return products;
    });
  }
}
