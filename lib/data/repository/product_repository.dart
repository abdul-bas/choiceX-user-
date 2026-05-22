import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coice/state/bloc/product/product_state/load_ratig_event.dart';
import 'package:coice/state/bloc/product/product_state/product_state.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProductBlocState> readReview({
    required String productId,
    required int variantIndex,
    required int limit,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('product')
          .doc(productId)
          .collection('rating')
          .get(); 

    
      final filteredReviews = snapshot.docs.where((doc) {
        final data = doc.data();

        if (!data.containsKey("id")) return false;

        final idParts = data["id"].toString().split("_");

        if (idParts.length < 3) return false;

        return idParts[1] == productId &&
            idParts[2] == variantIndex.toString();
      }).toList();

    
      final limitedReviews = filteredReviews.take(limit).toList();

     
      bool isEnd = limitedReviews.length < limit;

      if (limitedReviews.isEmpty) {
        return LoadRatigEventSuccessfully(
          ratings: [],
          isEnd: true,
        );
      }

      return LoadRatigEventSuccessfully(
        ratings: limitedReviews.map((e)=>e.data()).toList(), 
        isEnd: isEnd,
      );
    } catch (e) {
      print(e);
      return LoadRatigEventError(message: e.toString());
    }
  }
}
