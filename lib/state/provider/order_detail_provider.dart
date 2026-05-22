import 'package:coice/data/models/order_model.dart';
import 'package:coice/data/repository/auth_repository.dart';
import 'package:coice/ui/screens/order_details/dialogs/rating_bottom_sheet/rating_bottom_sheet.dart';
import 'package:flutter/material.dart';
class OrderDetailProvider extends ChangeNotifier {
  bool _isReviewed = false;
  bool get isReviewed => _isReviewed;

  String _status = '';
  String get status => _status;

  bool _ratingShown = false; 

  void updateStatus(String newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  Future<void> checkAndShowRating(
    BuildContext context,
    OrderModel items,
    TextEditingController reviewController,
  ) async {
    if (_ratingShown) return;

    final authRepository = AuthRepository();
    final userId = authRepository.getUeserId();

    final ratingKey =
        '${userId}_${items.productId}_${items.variantIndex}';

    if (items.itemStatus.toLowerCase() == 'delivered') {
      _isReviewed = await authRepository.isReviewed(
        productId: items.productId,
        key: ratingKey,
      );

      if (!_isReviewed) {
        _ratingShown = true;

        showRatingBottomSheet(
          variantIndex: items.variantIndex,
          userId: items.userId,
          context: context,
          reviewController: reviewController,
          ratingKey: ratingKey,
          productId: items.productId,
        );
      }

      notifyListeners();
    }
  }
}