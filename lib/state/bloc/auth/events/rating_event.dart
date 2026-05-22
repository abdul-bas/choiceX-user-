import 'package:coice/data/models/review_model.dart';
import 'package:coice/state/bloc/auth/events/auth_event.dart';

class TakeRating extends AuthEvent {
  final String productId;
  final String key;
  final ReviewDataModel review;
  final int variantIndex;

  TakeRating(
      {required this.productId, required this.key, required this.review,required this.variantIndex});
}
