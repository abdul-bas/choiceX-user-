import 'package:coice/state/bloc/order/order_state/return_request_state.dart';

class UpdateRequestState extends OrderBlocState {
  bool validate;
  String newStatus;
  String paymentId;
  double amount;
 

  UpdateRequestState(
      {required this.newStatus,
      required this.validate,
      required this.amount,
      required this.paymentId,});
}

class UpdateRequestStateError extends OrderBlocState {
  final String error;

  UpdateRequestStateError(this.error);
}
