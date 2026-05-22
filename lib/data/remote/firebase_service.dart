import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

class UiDetailsGet {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> productGet() {
    try {
      return _firestore.collection('product').snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getEachProduct(String id) {
    try {
      return _firestore.collection('product').doc(id).snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> particularProductGet(
      String productId) {
    try {
      return _firestore.collection('product').doc(productId).snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> categoryGet() {
    try {
      return _firestore.collection('category').snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> getBrand() {
    try {
      return _firestore.collection('brand').snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<QuerySnapshot> ordersGet() {
    try {
      final userId = AuthRepository().getUeserId();
      return _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> sellerGet(String sellerId) {
    try {
      return _firestore.collection('seller').doc(sellerId).snapshots();
    } catch (e) {
      debugPrint("Firestore error: $e");
      return const Stream.empty();
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSimilarProducts({
    required String category,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('product')
          .where('Category', isEqualTo: category)
          .limit(10)
          .get();
      return snapshot.docs;
    } catch (e) {
      return [];
    }
  }
}
